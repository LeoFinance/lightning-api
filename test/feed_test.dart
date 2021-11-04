import 'dart:convert';
import 'dart:io';
import 'package:lightning_api/lightning_api.dart';
import 'package:test/test.dart';

void main() {
  group('Feed', () {
    group('fromJson', () {
      test('decodes from JSON', () async {
        final json = await File('test/samples/feed.json')
            .readAsString()
            .then(jsonDecode);

        expect(Feed.fromJson(json),
            isA<Feed>().having((f) => f.items, 'items', hasLength(3)));
      });
    });
  });
}
