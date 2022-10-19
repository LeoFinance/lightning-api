import 'dart:convert';
import 'dart:io';
import 'package:leofinance_lightning_api/lightning_api.dart';
import 'package:test/test.dart';

void main() {
  group('Feed', () {
    group('fromJson', () {
      test('decodes from JSON', () async {
        final s = await File('test/samples/feed.json').readAsString();
        final json = jsonDecode(s) as Map<String, dynamic>;

        expect(
          Feed.fromJson(json),
          isA<Feed>().having((f) => f.posts, 'posts', hasLength(20)),
        );
      });
    });
  });
}
