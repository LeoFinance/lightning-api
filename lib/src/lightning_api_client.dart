import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../lightning_api.dart';

class LightningApiClient {
  static const _baseUrl = 'beta.leofinance.io';
  final http.Client _httpClient;

  /// {@macro lightning_api_client}
  LightningApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<Content> getContent(authorperm) async {
    final uri = Uri.https(_baseUrl, '/lightning/content/$authorperm');

    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw NotFoundFailure('Could not find content for $authorperm');
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw NotFoundFailure('Could not find content $authorperm');
    }

    try {
      return Content.fromJson(bodyJson);
    } catch (e, s) {
      print('Failed to parse $authorperm: $e');
      print(s);
      print('Failed data: $bodyJson');
      throw e;
    }
  }

  Future<Comments> getComments(authorperm) async {
    final uri = Uri.https(_baseUrl, '/lightning/comments/$authorperm');

    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw NotFoundFailure('Could not find comments for $authorperm');
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw NotFoundFailure('Could not find comments for $authorperm');
    }

    try {
      return Comments.fromJson(bodyJson);
    } catch (e, s) {
      print('Failed to parse $authorperm: $e');
      print(s);
      print('Failed data: $bodyJson');
      throw e;
    }
  }

  // Future<Excerpt> getExcerpt(authorperm) async {
  //   final uri = Uri.https(_baseUrl, '/lightning/excerpts/$authorperm');

  //   final postResponse = await _httpClient.get(uri);

  //   if (postResponse.statusCode != 200) {
  //     if (postResponse.statusCode == 404) {
  //       throw NotFoundFailure('Could not find content for $authorperm');
  //     } else {
  //       throw ContentRequestFailure(statusCode: postResponse.statusCode);
  //     }
  //   }

  //   final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

  //   if (bodyJson.isEmpty) {
  //     throw NotFoundFailure('Could not find content $authorperm');
  //   }

  //   try {
  //     return Excerpt.fromJson(bodyJson);
  //   } catch (e, s) {
  //     print('Failed to parse $authorperm: $e');
  //     print(s);
  //     print('Failed data: $bodyJson');
  //     throw e;
  //   }
  // }

  Future<Feed> getFeed(
      {required String tag, required String sort, int? limit}) async {
    final uri = Uri.https(_baseUrl, '/lightning/feeds/$tag/$sort');
    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw NotFoundFailure('Could not find feed $tag/$sort');
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body);

    return Feed.fromJson(bodyJson);
  }

  Future<List<Content>> getPosts(
      {required String tag, required String sort, int? limit}) async {
    final uri = Uri.https(_baseUrl, '/lightning/posts/$tag/$sort');
    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw NotFoundFailure('Could not find feed $tag/$sort');
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as List;

    return bodyJson.map((e) => Content.fromJson(e)).toList();
  }

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
