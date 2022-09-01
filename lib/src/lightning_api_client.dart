import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lightning_api/lightning_api.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

enum FeedSortOrder { curated, created, trending, promoted, hot, blog, feed }

class LightningApiClient {
  /// {@macro lightning_api_client}
  LightningApiClient({this.httpClient});

  final http.Client? httpClient;
  static const _baseUrl = 'lightning.leofinance.io';

  final _accountStreamControllers = <String, BehaviorSubject<Account?>>{};

  final _feedStreamControllers = <String, BehaviorSubject<Feed>>{};
  final _postStreamControllers = <Authorperm, BehaviorSubject<Post?>>{};

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

  String _getKey(String tag, String sort) => '$tag:$sort';

  Future<void> _fetchAndAddFeed({
    required String tag,
    required FeedSortOrder sort,
    int? start,
    int? limit,
    bool requestLatest = false,
  }) async {
    final key = _getKey(tag, sort.name);

    assert(_feedStreamControllers.containsKey(key), 'Missing key $key');

    try {
      _feedStreamControllers[key]!.add(
        await _fetchFeed(
          tag: tag,
          sort: sort,
          start: start,
          limit: limit,
          requestLatest: requestLatest,
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
      throw const NotFoundFailure('Feed not found');
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
      throw const NotFoundFailure('Feed not found');
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
    required String tag,
    required FeedSortOrder sort,
    int? start,
    int? limit,
    bool requestLatest = false,
  }) async {
    final queryParameters = <String, String>{};
    if (start != null) queryParameters['start'] = start.toString();
    if (limit != null) queryParameters['limit'] = limit.toString();
    if (requestLatest) queryParameters['latest'] = '1';

    final uri = Uri.https(
      _baseUrl,
      '/feeds/$tag/${sort.name}',
      queryParameters.isNotEmpty ? queryParameters : null,
    );
    final postResponse = await _httpGet(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw NotFoundFailure('Could not find feed $tag/${sort.name}');
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    return Feed.fromJson(bodyJson);
  }

  Future<http.Response> _httpGet(Uri url, {Map<String, String>? headers}) {
    return httpClient != null
        ? httpClient!.get(url, headers: headers)
        : http.get(url, headers: headers);
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

    final postResponse = await _httpGet(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        return null;
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

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

    final postResponse = await _httpGet(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        return null;
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    return Comments.fromJson(bodyJson);
  }

  /// Refresh the comments and add it to the stream
  Future<void> refreshComments(Authorperm id) async {
    if (!_commentsStreamControllers.containsKey(id)) {
      throw const NotFoundFailure('Comments not found');
    }

    unawaited(_fetchAndAddComments(id, requestLatest: true));
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
