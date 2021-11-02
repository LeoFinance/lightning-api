import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../lightning_api.dart';

class LightningApiClient {
  static const _baseUrl = 'alpha.leofinance.io';
  final http.Client _httpClient;

  /// {@macro lightning_api_client}
  LightningApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<Content> getContent(authorperm) async {
    final uri = Uri.https(_baseUrl, '/lightning/posts/$authorperm');

    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        final ap = Authorperm.parse(authorperm);
        throw PostNotFoundFailure(ap.author, ap.permlink);
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      final ap = Authorperm.parse(authorperm);
      throw PostNotFoundFailure(ap.author, ap.permlink);
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

  Future<Feed> getFeed({required String tag, required String sort}) async {
    final uri = Uri.https(_baseUrl, '/lightning/feeds/$tag/$sort');
    final postResponse = await _httpClient.get(uri);

    if (postResponse.statusCode != 200) {
      if (postResponse.statusCode == 404) {
        throw FeedNotFoundFailure(sort: sort, tag: tag);
      } else {
        throw ContentRequestFailure(statusCode: postResponse.statusCode);
      }
    }

    final bodyJson = jsonDecode(postResponse.body) as List<dynamic>;

    return Feed.fromJson(bodyJson);
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
