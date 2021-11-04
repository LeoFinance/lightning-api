// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lightning_api/lightning_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'lightning_api_client_test.mocks.dart';

@GenerateMocks([http.Client, http.Response, LightningApiClient])
void main() {
  group('LightningApiClient', () {
    late http.Client httpClient;
    late LightningApiClient lightningApiClient;

    setUp(() {
      httpClient = MockClient();
      lightningApiClient = LightningApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(LightningApiClient(), isNotNull);
      });
    });

    group('getPost', () {
      const authorperm = '@cwow2/selling-my-hive-goodbye';
      final lightningUri =
          Uri.https('alpha.leofinance.io', '/lightning/posts/$authorperm');

      test('throws ContentRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(400);
        when(httpClient.get(lightningUri)).thenAnswer((_) async => response);
        expect(
          lightningApiClient.getContent(authorperm),
          throwsA(isA<ContentRequestFailure>()),
        );
      });

      test('throws PostNotFoundFailure on 404', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(404);
        when(httpClient.get(lightningUri)).thenAnswer((_) async => response);
        expect(
          lightningApiClient.getContent(authorperm),
          throwsA(isA<PostNotFoundFailure>()),
        );
      });

      test('returns Post on valid response', () async {
        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body)
            .thenReturn(await File('test/samples/content.json').readAsString());
        when(httpClient.get(lightningUri)).thenAnswer((_) async => response);
        final actual = await lightningApiClient.getContent(authorperm);
        verify(
          httpClient.get(lightningUri),
        ).called(1);

        expect(
            actual,
            isA<Content>()
                .having((p) => p.postId, 'postId', 107387380)
                .having((p) => p.author, 'author', 'cwow2')
                .having(
                    (p) => p.permlink, 'permlink', 'selling-my-hive-goodbye')
                .having((p) => p.upvotes, 'upvotes', hasLength(29))
                .having((p) => p.downvotes, 'downvotes', hasLength(1)));
      });
    });
  });
}
