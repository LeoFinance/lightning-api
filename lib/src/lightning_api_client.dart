import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lightning_api/lightning_api.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

enum FeedSortOrder { curated, created, trending, promoted, hot, blog, feed }

extension FeedSortOrderExtension on FeedSortOrder {
  ThreadsSortOrder toThreadsSortOrder() {
    switch (this) {
      case FeedSortOrder.created:
        return ThreadsSortOrder.created;
      case FeedSortOrder.trending:
        return ThreadsSortOrder.trending;
      // ignore: no_default_cases
      default:
        throw const IllegalSortException();
    }
  }
}

class IllegalSortException implements Exception {
  const IllegalSortException();
}

enum ThreadsSortOrder { created, trending }

extension ThreadsSortOrderExtension on ThreadsSortOrder {
  FeedSortOrder toFeedSortOrder() {
    return this == ThreadsSortOrder.created
        ? FeedSortOrder.created
        : FeedSortOrder.trending;
  }
}

class LightningApiClient {
  /// {@macro lightning_api_client}
  LightningApiClient({this.httpClient});

  static const _baseUrl = 'lightning.leofinance.io';

  final http.Client? httpClient;
  final log = Logger('LightningApiClient');

  final _accountStreamControllers = <String, BehaviorSubject<Account?>>{};

  final _feedStreamControllers = <String, BehaviorSubject<Feed>>{};
  final _postStreamControllers = <Authorperm, BehaviorSubject<Post?>>{};
  final _threadStreamControllers = <Authorperm, BehaviorSubject<Thread?>>{};

  final _commentsStreamControllers = <Authorperm, BehaviorSubject<Comments?>>{};

  Stream<Account?> getAccount(String name) {
    final BehaviorSubject<Account?> controller;
    if (_accountStreamControllers.containsKey(name)) {
      controller = _accountStreamControllers[name]!;
    } else {
      controller = BehaviorSubject<Account?>();
      _accountStreamControllers[name] = controller;

      unawaited(_fetchAndAddAccount(name));
    }

    return controller.asBroadcastStream();
  }

  Future<void> _fetchAndAddAccount(String name) async {
    assert(
      _accountStreamControllers.containsKey(name),
      'Missing account $name',
    );

    try {
      _accountStreamControllers[name]!.add(await _fetchAccount(name));
    } catch (e, s) {
      _accountStreamControllers[name]!.addError(e, s);
    }
  }

  Future<Account?> _fetchAccount(String name) async {
    final uri = Uri.https(
      _baseUrl,
      '/accounts/$name',
    );

    final postResponse = await _httpGet(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        return null;
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    return Account.fromJson(bodyJson);
  }

  Stream<Feed> getFeed({
    required String tag,
    required FeedSortOrder sort,
    bool requestLatest = false,
  }) {
    final key = _getKey(tag, sort.name);
    final BehaviorSubject<Feed> controller;
    if (_feedStreamControllers.containsKey(key)) {
      controller = _feedStreamControllers[key]!;
    } else {
      controller = BehaviorSubject<Feed>();
      _feedStreamControllers[key] = controller;

      unawaited(
        _fetchAndAddFeed(
          tag: tag,
          sort: sort,
          requestLatest: requestLatest,
        ),
      );
    }

    return controller.asBroadcastStream();
  }

  String _getKey(String? tag, String? sort) => '$tag:$sort';
  String _getThreadsKey(String? tag, String? sort) => 'threads:$tag:$sort';

  Future<void> _fetchAndAddFeed({
    String? tag,
    FeedSortOrder? sort,
    int? start,
    int? limit,
    bool requestLatest = false,
    bool isThreads = false,
  }) async {
    final key =
        isThreads ? _getThreadsKey(tag, sort?.name) : _getKey(tag, sort?.name);

    assert(_feedStreamControllers.containsKey(key), 'Missing key $key');

    try {
      _feedStreamControllers[key]!.add(
        await _fetchFeed(
          tag: tag,
          sort: sort,
          start: start,
          limit: limit,
          requestLatest: requestLatest,
          isThreads: isThreads,
        ),
      );
    } catch (e, s) {
      _feedStreamControllers[key]!.addError(e, s);
    }
  }

  /// Refresh the feed and add it to the stream
  Future<void> refreshFeed({
    required String tag,
    required FeedSortOrder sort,
  }) async {
    final key = _getKey(tag, sort.name);
    if (!_feedStreamControllers.containsKey(key)) {
      throw NotFoundFailure('Feed $key not found');
    }

    unawaited(_fetchAndAddFeed(tag: tag, sort: sort, requestLatest: true));
  }

  /// Expand the feed and add it to the stream
  Future<void> expandFeed({
    required String tag,
    required FeedSortOrder sort,
    int amount = 20,
  }) async {
    final key = _getKey(tag, sort.name);
    if (!_feedStreamControllers.containsKey(key)) {
      throw NotFoundFailure('Feed $key not found');
    }

    final curFeed = _feedStreamControllers[key]!.value;

    unawaited(
      _fetchAndAddFeed(
        tag: tag,
        sort: sort,
        start: 0, // FIXME Only get the items to expand
        // start: curFeed.length >= 2 ? curFeed.length - 2 : 0,
        limit: curFeed.length + amount,
      ),
    );

    // var lastDuplicate = feed.posts.indexOf(newFeed[0]);
    // if (lastDuplicate == -1) {
    //   // FIXME We will miss some items if this happens; not a big deal IMHO
    //   lastDuplicate = feed.length;
    // }
    // final expandedFeed = Feed(
    //     tag: feedData.tag,
    //     sort: feedData.sort.name,
    //     posts: [...feed.posts.getRange(0, lastDuplicate), ...newFeed.posts]);
  }

  Future<Feed> _fetchFeed({
    String? tag,
    FeedSortOrder? sort,
    int? start,
    int? limit,
    bool requestLatest = false,
    bool isThreads = false,
  }) async {
    final queryParameters = <String, String>{};
    if (start != null) queryParameters['start'] = start.toString();
    if (limit != null) queryParameters['limit'] = limit.toString();
    if (requestLatest) queryParameters['latest'] = '1';

    if (isThreads) {
      if (tag != null) queryParameters['tag'] = tag;
      if (sort != null) queryParameters['sort'] = sort.name;
    }

    final uri = isThreads
        ? Uri.https(
            _baseUrl,
            '/v2/threads',
            queryParameters.isNotEmpty ? queryParameters : null,
          )
        : Uri.https(
            _baseUrl,
            '/feeds/$tag/${sort!.name}',
            queryParameters.isNotEmpty ? queryParameters : null,
          );
    final postResponse = await _httpGet(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw NotFoundFailure('Could not find feed $tag/${sort?.name}');
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    return Feed.fromJson(bodyJson);
  }

  Future<http.Response> _httpGet(Uri url, {Map<String, String>? headers}) {
    log.info('HTTP GET $url');
    return httpClient != null
        ? httpClient!.get(url, headers: headers)
        : http.get(url, headers: headers);
  }

  Stream<Feed> getThreads({
    String? tag,
    ThreadsSortOrder? sort,
    bool requestLatest = false,
  }) {
    final key = _getThreadsKey(tag, sort?.name);
    final BehaviorSubject<Feed> controller;
    if (_feedStreamControllers.containsKey(key)) {
      controller = _feedStreamControllers[key]!;
    } else {
      controller = BehaviorSubject<Feed>();
      _feedStreamControllers[key] = controller;

      unawaited(
        _fetchAndAddFeed(
          tag: tag,
          sort: sort?.toFeedSortOrder(),
          requestLatest: requestLatest,
          isThreads: true,
        ),
      );
    }

    return controller.asBroadcastStream();
  }

  /// Refresh the feed and add it to the stream
  Future<void> refreshThreads({
    String? tag,
    ThreadsSortOrder? sort,
  }) async {
    final key = _getThreadsKey(tag, sort?.name);
    if (!_feedStreamControllers.containsKey(key)) {
      throw NotFoundFailure('Threads $key not found');
    }

    unawaited(
      _fetchAndAddFeed(
        tag: tag,
        sort: sort?.toFeedSortOrder(),
        requestLatest: true,
        isThreads: true,
      ),
    );
  }

  /// Expand the feed and add it to the stream
  Future<void> expandThreads({
    String? tag,
    ThreadsSortOrder? sort,
    int amount = 20,
  }) async {
    final key = _getThreadsKey(tag, sort?.name);
    if (!_feedStreamControllers.containsKey(key)) {
      throw NotFoundFailure('Threads $key not found');
    }

    final curFeed = _feedStreamControllers[key]!.value;

    unawaited(
      _fetchAndAddFeed(
        tag: tag,
        sort: sort?.toFeedSortOrder(),
        start: 0, // FIXME Only get the items to expand
        // start: curFeed.length >= 2 ? curFeed.length - 2 : 0,
        limit: curFeed.length + amount,
        isThreads: true,
      ),
    );

    // var lastDuplicate = feed.posts.indexOf(newFeed[0]);
    // if (lastDuplicate == -1) {
    //   // FIXME We will miss some items if this happens; not a big deal IMHO
    //   lastDuplicate = feed.length;
    // }
    // final expandedFeed = Feed(
    //     tag: feedData.tag,
    //     sort: feedData.sort.name,
    //     posts: [...feed.posts.getRange(0, lastDuplicate), ...newFeed.posts]);
  }

  ValueStream<Post?> getPost(Authorperm id) {
    final BehaviorSubject<Post?> controller;
    if (_postStreamControllers.containsKey(id)) {
      controller = _postStreamControllers[id]!;
    } else {
      controller = BehaviorSubject<Post?>();
      _postStreamControllers[id] = controller;

      unawaited(_fetchAndAddPost(id));
    }

    return controller;
  }

  Future<void> _fetchAndAddPost(
    Authorperm id, {
    bool requestLatest = false,
  }) async {
    assert(_postStreamControllers.containsKey(id), 'Missing post stream $id');

    try {
      _postStreamControllers[id]!
          .add(await _fetchPost(id, requestLatest: requestLatest));
    } catch (e, s) {
      _postStreamControllers[id]!.addError(e, s);
    }
  }

  Future<Post?> _fetchPost(Authorperm id, {bool requestLatest = false}) async {
    final uri = Uri.https(
      _baseUrl,
      '/content/$id',
      <String, dynamic>{'latest': requestLatest == true ? '1' : '0'},
    );

    final response = await _httpGet(uri);

    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        return null;
      } else {
        throw ContentRequestFailure(statusCode: response.statusCode);
      }
    }

    final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

    return Post.fromJson(bodyJson);
  }

  /// Refresh the post and add it to the stream
  Future<void> refreshPost(Authorperm id) async {
    return _fetchAndAddPost(id, requestLatest: true);
  }

  ValueStream<Comments?> getComments(Authorperm postId) {
    final BehaviorSubject<Comments?> controller;
    if (_commentsStreamControllers.containsKey(postId)) {
      controller = _commentsStreamControllers[postId]!;
    } else {
      controller = BehaviorSubject<Comments?>();
      _commentsStreamControllers[postId] = controller;

      unawaited(_fetchAndAddComments(postId));
    }

    return controller;
  }

  Future<void> _fetchAndAddComments(
    Authorperm id, {
    bool requestLatest = false,
  }) async {
    assert(
      _commentsStreamControllers.containsKey(id),
      'Missing comments entry for $id',
    );

    try {
      _commentsStreamControllers[id]!
          .add(await _fetchComments(id, requestLatest: requestLatest));
    } catch (e, s) {
      _commentsStreamControllers[id]!.addError(e, s);
    }
  }

  Future<Comments?> _fetchComments(
    Authorperm id, {
    bool requestLatest = false,
  }) async {
    final uri = Uri.https(
      _baseUrl,
      '/comments/$id',
      <String, dynamic>{'latest': requestLatest == true ? '1' : '0'},
    );

    final response = await _httpGet(uri);

    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        return null;
      } else {
        throw ContentRequestFailure(statusCode: response.statusCode);
      }
    }

    final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

    return Comments.fromJson(bodyJson);
  }

  /// Refresh the comments and add it to the stream
  Future<void> refreshComments(Authorperm id) async {
    if (!_commentsStreamControllers.containsKey(id)) {
      throw NotFoundFailure('Comments $id not found');
    }

    unawaited(_fetchAndAddComments(id, requestLatest: true));
  }

  ValueStream<Thread?> getThread(Authorperm id) {
    final BehaviorSubject<Thread?> controller;
    if (_postStreamControllers.containsKey(id)) {
      controller = _threadStreamControllers[id]!;
    } else {
      controller = BehaviorSubject<Thread?>();
      _threadStreamControllers[id] = controller;

      unawaited(_fetchAndAddThread(id));
    }

    return controller;
  }

  Future<void> _fetchAndAddThread(
    Authorperm id, {
    bool requestLatest = false,
  }) async {
    assert(
      _threadStreamControllers.containsKey(id),
      'Missing thread stream $id',
    );

    try {
      _threadStreamControllers[id]!
          .add(await _fetchThread(id, requestLatest: requestLatest));
    } catch (e, s) {
      _threadStreamControllers[id]!.addError(e, s);
    }
  }

  Future<Thread?> _fetchThread(
    Authorperm id, {
    bool requestLatest = false,
  }) async {
    final uri = Uri.https(
      _baseUrl,
      '/v2/threads/$id',
      <String, dynamic>{'latest': requestLatest == true ? '1' : '0'},
    );

    final response = await _httpGet(uri);

    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        return null;
      } else {
        throw ContentRequestFailure(statusCode: response.statusCode);
      }
    }

    final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

    return Thread.fromJson(bodyJson);
  }

  /// Refresh the thread and add it to the stream
  Future<void> refreshThread(Authorperm id) async {
    return _fetchAndAddThread(id, requestLatest: true);
  }

  Future<Map<String, int>?> getThreadTags({bool requestLatest = false}) async {
    final uri = Uri.https(
      _baseUrl,
      '/v2/threads/tags',
      <String, dynamic>{'latest': requestLatest == true ? '1' : '0'},
    );

    final response = await _httpGet(uri);

    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        return null;
      } else {
        throw ContentRequestFailure(statusCode: response.statusCode);
      }
    }

    final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

    return Map<String, int>.from(bodyJson);
  }

  Future<Map<String, dynamic>?> getMetadata(
    String url, {
    bool requestLatest = false,
  }) async {
    final uri = Uri.https(
      _baseUrl,
      '/v2/metadata',
      <String, dynamic>{'u': url, 'latest': requestLatest == true ? '1' : '0'},
    );

    final response = await _httpGet(uri);

    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        return null;
      } else {
        throw ContentRequestFailure(statusCode: response.statusCode);
      }
    }

    final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

    return bodyJson;
  }

  // /// Find and return the id of the post which contains the given comment.
  // Authorperm findPostIdForComment(Authorperm id) {
  //   return _commentsStreamControllers.values
  //       .firstWhere((s) => s.value.containsComment(id))
  //       .value
  //       .parent;
  // }

  Future<SearchResults> search(String query, {int? start, int? limit}) async {
    final params = {'q': query};
    if (start != null) {
      params['start'] = start.toString();
    }
    if (limit != null) {
      params['limit'] = limit.toString();
    }
    final uri = Uri.https(_baseUrl, '/search', params);

    final searchResult = await _httpGet(uri);

    if (searchResult.statusCode != 200) {
      throw ContentRequestFailure(statusCode: searchResult.statusCode);
    }

    final bodyJson = jsonDecode(searchResult.body) as Map<String, dynamic>;

    return SearchResults.fromJson(bodyJson);
  }

  // Future<Excerpt> getExcerpt(id) async {
  //   final uri = Uri.https(_baseUrl, '/excerpts/$id');

  //   final postResponse = await _httpClient.get(uri);

  //   if (postResponse.statusCode != 200) {
  //     if (postResponse.statusCode == 404) {
  //       throw NotFoundFailure('Could not find content for $id');
  //     } else {
  //       throw ContentRequestFailure(statusCode: postResponse.statusCode);
  //     }
  //   }

  //   final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

  //   if (bodyJson.isEmpty) {
  //     throw NotFoundFailure('Could not find content $id');
  //   }

  //   try {
  //     return Excerpt.fromJson(bodyJson);
  //   } catch (e, s) {
  //     print('Failed to parse $id: $e');
  //     print(s);
  //     print('Failed data: $bodyJson');
  //     throw e;
  //   }
  // }

  // Future<List<Content>> getPosts(
  //     {required String tag,
  //     required String sort,
  //     int? start,
  //     int? limit}) async {
  //   final queryParameters = <String, String>{};
  //   if (start != null) queryParameters['start'] = start.toString();
  //   if (limit != null) queryParameters['limit'] = limit.toString();
  //   final uri = Uri.https(_baseUrl, '/posts/$tag/$sort',
  //       queryParameters.isNotEmpty ? queryParameters : null);
  //   final postResponse = await _httpClient.get(uri);

  //   if (postResponse.statusCode != 200) {
  //     if (postResponse.statusCode == 404) {
  //       throw NotFoundFailure('Could not find feed $tag/$sort');
  //     } else {
  //       throw ContentRequestFailure(statusCode: postResponse.statusCode);
  //     }
  //   }

  //   final bodyJson = jsonDecode(postResponse.body) as List;

  //   return bodyJson.map((e) => Content.fromJson(e)).toList();
  // }

  // Future<List<dynamic>> getFeedJson(
  //     {required String tag, required String sort}) async {
  //   final uri = Uri.https(_baseUrl, '/feeds/$tag/$sort');
  //   print('GET $uri');
  //   final postResponse = await _httpClient.get(uri);

  //   if (postResponse.statusCode != 200) {
  //     throw ContentRequestFailure(statusCode: postResponse.statusCode);
  //   }

  //   return jsonDecode(postResponse.body) as List<dynamic>;
  // }
}
