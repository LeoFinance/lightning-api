import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';
import '../lightning_api.dart';

class LightningApiClient {
  static const _baseUrl = 'beta.leofinance.io';
  final http.Client _httpClient;

  final _feedStreamControllers = Map<String, BehaviorSubject<Feed>>();
  final _postStreamControllers = Map<Authorperm, BehaviorSubject<Post>>();
  final _commentsStreamControllers =
      Map<Authorperm, BehaviorSubject<Comments>>();

  /// {@macro lightning_api_client}
  LightningApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Stream<Feed> getFeed({required String tag, required String sort}) {
    final key = _getKey(tag, sort);
    final BehaviorSubject<Feed> controller;
    if (_feedStreamControllers.containsKey(key)) {
      controller = _feedStreamControllers[key]!;
    } else {
      controller = BehaviorSubject<Feed>.seeded(
          Feed(tag: tag, sort: sort, posts: const []));
      _feedStreamControllers[key] = controller;

      unawaited(_fetchAndAddFeed(tag: tag, sort: sort));
    }

    return controller.asBroadcastStream();
  }

  String _getKey(String tag, String sort) => '$tag:$sort';

  Future<void> _fetchAndAddFeed(
      {required String tag,
      required String sort,
      int? start,
      int? limit}) async {
    final key = _getKey(tag, sort);

    assert(_feedStreamControllers.containsKey(key));

    try {
      _feedStreamControllers[key]!.add(
          await _fetchFeed(tag: tag, sort: sort, start: start, limit: limit));
    } catch (e, s) {
      _feedStreamControllers[key]!.addError(e, s);
    }
  }

  /// Refresh the feed and add it to the stream
  void refreshFeed({required String tag, required String sort}) async {
    final key = _getKey(tag, sort);
    if (!_feedStreamControllers.containsKey(key)) {
      throw NotFoundFailure('Feed not found');
    }

    unawaited(_fetchAndAddFeed(tag: tag, sort: sort));
  }

  /// Expand the feed and add it to the stream
  void expandFeed(
      {required String tag, required String sort, int amount = 20}) async {
    final key = _getKey(tag, sort);
    if (!_feedStreamControllers.containsKey(key)) {
      throw NotFoundFailure('Feed not found');
    }

    final curFeed = _feedStreamControllers[key]!.value;

    unawaited(_fetchAndAddFeed(
        tag: tag,
        sort: sort,
        start: 0, // TODO Only get the items to expand
        // start: curFeed.length >= 2 ? curFeed.length - 2 : 0,
        limit: curFeed.length + amount));

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

  Future<Feed> _fetchFeed(
      {required String tag,
      required String sort,
      int? start,
      int? limit}) async {
    final queryParameters = <String, String>{};
    if (start != null) queryParameters['start'] = start.toString();
    if (limit != null) queryParameters['limit'] = limit.toString();

    final uri = Uri.https(_baseUrl, '/lightning/feeds/$tag/$sort',
        queryParameters.isNotEmpty ? queryParameters : null);
    print(uri);
    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw NotFoundFailure('Could not find feed $tag/$sort');
      } else {
        print('Received HTTP ${postResponse.statusCode} calling $uri');
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body);

    return Feed.fromJson(bodyJson);
  }

  Stream<Post> getPost(Authorperm id) {
    final BehaviorSubject<Post> controller;
    if (_postStreamControllers.containsKey(id)) {
      controller = _postStreamControllers[id]!;
    } else {
      controller = BehaviorSubject<Post>();
      _postStreamControllers[id] = controller;

      unawaited(_fetchAndAddPost(id));
    }

    return controller.asBroadcastStream();
  }

  Future<void> _fetchAndAddPost(Authorperm id) async {
    assert(_postStreamControllers.containsKey(id));

    try {
      _postStreamControllers[id]!.add(await _fetchPost(id));
    } catch (e, s) {
      _postStreamControllers[id]!.addError(e, s);
    }
  }

  Future<Post> _fetchPost(Authorperm id, {bool? forceLatest}) async {
    final uri = Uri.https(
        _baseUrl,
        '/lightning/content/$id',
        forceLatest != null
            ? {'latest': forceLatest == true ? '1' : '0'}
            : null);

    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw NotFoundFailure('Could not find content for $id');
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw NotFoundFailure('Could not find content $id');
    }

    try {
      return Post.fromJson(bodyJson);
    } catch (e, s) {
      print('Failed to parse $id: $e');
      print(s);
      print('Failed data: $bodyJson');
      throw e;
    }
  }

  /// Refresh the post and add it to the stream
  void refreshPost(Authorperm id) async {
    if (!_postStreamControllers.containsKey(id)) {
      throw NotFoundFailure('Post not found');
    }

    unawaited(_fetchAndAddPost(id));
  }

  Stream<Comments> getComments(Authorperm id) {
    final BehaviorSubject<Comments> controller;
    if (_commentsStreamControllers.containsKey(id)) {
      controller = _commentsStreamControllers[id]!;
    } else {
      controller = BehaviorSubject<Comments>();
      _commentsStreamControllers[id] = controller;

      unawaited(_fetchAndAddComments(id));
    }

    return controller.asBroadcastStream();
  }

  Future<void> _fetchAndAddComments(Authorperm id) async {
    assert(_commentsStreamControllers.containsKey(id));

    try {
      _commentsStreamControllers[id]!.add(await _fetchComments(id));
    } catch (e, s) {
      _feedStreamControllers[id]!.addError(e, s);
    }
  }

  Future<Comments> _fetchComments(Authorperm id, {bool? forceLatest}) async {
    final uri = Uri.https(
        _baseUrl,
        '/lightning/comments/$id',
        forceLatest != null
            ? {'latest': forceLatest == true ? '1' : '0'}
            : null);

    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw NotFoundFailure('Could not find comments for $id');
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw NotFoundFailure('Could not find comments for $id');
    }

    try {
      return Comments.fromJson(bodyJson);
    } catch (e, s) {
      print('Failed to parse $id: $e');
      print(s);
      print('Failed data: $bodyJson');
      throw e;
    }
  }

  /// Refresh the comments and add it to the stream
  void refreshComments(Authorperm id) async {
    if (!_commentsStreamControllers.containsKey(id)) {
      throw NotFoundFailure('Comments not found');
    }

    unawaited(_fetchAndAddComments(id));
  }

  // Future<Excerpt> getExcerpt(id) async {
  //   final uri = Uri.https(_baseUrl, '/lightning/excerpts/$id');

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
  //   final uri = Uri.https(_baseUrl, '/lightning/posts/$tag/$sort',
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
  //   final uri = Uri.https(_baseUrl, '/lightning/feeds/$tag/$sort');
  //   print('GET $uri');
  //   final postResponse = await _httpClient.get(uri);

  //   if (postResponse.statusCode != 200) {
  //     throw ContentRequestFailure(statusCode: postResponse.statusCode);
  //   }

  //   return jsonDecode(postResponse.body) as List<dynamic>;
  // }
}
