// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:lightning_api/lightning_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'lightning_api_client_test.mocks.dart';
import 'samples/samples.dart';

// import 'lightning_api_client_test.mocks.dart';

@GenerateMocks([http.Client, http.Response, LightningApiClient])
void main() {
  group('LightningApiClient', () {
    late MockClient httpClient;
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

    group('getAccount', () {
      test('returns Stream with account when found', () async {
        final name = faker.internet.userName();
        final account = Account.fromJson(
          await loadSample('test/samples/account.json'),
        );

        final response = MockResponse();
        when(response.statusCode).thenReturn(200);
        when(response.body).thenReturn(jsonEncode(account));
        when(httpClient.get(any)).thenAnswer((_) async => response);

        expect(
          lightningApiClient.getAccount(name),
          emitsInOrder(<dynamic>[isA<Account>()]),
        );
      });

      test('returns Stream with null when not found', () async {
        final name = faker.internet.userName();

        final response = MockResponse();
        when(response.statusCode).thenReturn(404);
        when(httpClient.get(any)).thenAnswer((_) async => response);

        expect(
          lightningApiClient.getAccount(name),
          emitsInOrder(<dynamic>[isNull]),
        );
      });
    });

    group('getPost', () {
      test('returns Stream with null when post not found', () async {
        final author = faker.internet.userName();
        final permlink = faker.randomGenerator.string(10);
        final authorperm = Authorperm(author, permlink);

        final response = MockResponse();
        when(response.statusCode).thenReturn(404);
        when(httpClient.get(any)).thenAnswer((_) async => response);

        expect(
          lightningApiClient.getPost(authorperm),
          emitsInOrder(<dynamic>[isNull]),
        );
      });
    });

    group('getComments', () {
      test('returns Stream with null when post not found', () async {
        final author = faker.internet.userName();
        final permlink = faker.randomGenerator.string(10);
        final authorperm = Authorperm(author, permlink);

        final response = MockResponse();
        when(response.statusCode).thenReturn(404);
        when(httpClient.get(any)).thenAnswer((_) async => response);

        expect(
          lightningApiClient.getComments(authorperm),
          emitsInOrder(<dynamic>[isNull]),
        );
      });
    });

    // test('returns null when account not found', () async {
    //   const name = 'userNotFound';
    //   const key = 'user:$name';
    //   when(
    //     hiveApiClient.getAccounts([name]),
    //   ).thenAnswer((_) async => []);

    //   // This is ignored
    //   when(scotApiClient.getAccountForToken(name, token: token)).thenAnswer(
    //     (_) async => scot_api.Account.fromJson(
    //       await loadSample('test/samples/scot_account.json'),
    //     ),
    //   );
    //   when(redisStore.exists(key)).thenAnswer((_) async => false);

    //   expect(await lightningRepository.getAccount(name), isNull);
    //   verify(hiveApiClient.getAccounts([name])).called(1);
    //   verify(scotApiClient.getAccountForToken(name, token: token)).called(1);
    //   verifyNever(redisStore.getJson(key));
    //   verify(redisStore.setJson(key, null)).called(1);
    // });
  });

  // group('getPost', () {
  //   const authorperm = Authorperm('cwow2', 'selling-my-hive-goodbye');
  //   final lightningUri =
  //       Uri.https('alpha.leofinance.io', '/lightning/posts/$authorperm');

  //   test('throws ContentRequestFailure on non-200 response', () async {
  //     final response = MockResponse();
  //     when(response.statusCode).thenReturn(400);
  //     when(httpClient.get(lightningUri)).thenAnswer((_) async => response);
  //     expect(
  //       lightningApiClient._fetchPost(authorperm),
  //       throwsA(isA<ContentRequestFailure>()),
  //     );
  //   });

  //   test('throws NotFoundFailure on 404', () async {
  //     final response = MockResponse();
  //     when(response.statusCode).thenReturn(404);
  //     when(httpClient.get(lightningUri)).thenAnswer((_) async => response);
  //     expect(
  //       lightningApiClient._fetchPost(authorperm),
  //       throwsA(isA<NotFoundFailure>()),
  //     );
  //   });

  //   test('returns Post on valid response', () async {
  //     final response = MockResponse();
  //     when(response.statusCode).thenReturn(200);
  //     when(response.body)
  //         .thenReturn(await File('test/samples/content.json').readAsString());
  //     when(httpClient.get(lightningUri)).thenAnswer((_) async => response);
  //     final actual = await lightningApiClient._fetchPost(authorperm);
  //     verify(
  //       httpClient.get(lightningUri),
  //     ).called(1);

  //   expect(
  //       actual,
  //       isA<Post>()
  //           .having((p) => p.id, 'id', 107387380)
  //           .having((p) => p.author, 'author', 'cwow2')
  //           .having(
  //               (p) => p.permlink, 'permlink', 'selling-my-hive-goodbye')
  //           .having((p) => p.upvotes, 'upvotes', hasLength(29))
  //           .having((p) => p.downvotes, 'downvotes', hasLength(1)));
  // });
  // });
}
