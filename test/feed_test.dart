import 'dart:convert';
import 'dart:io';
import 'helpers/fakes.dart';
import 'package:lightning_api_models/lightning_api_models.dart';
import 'package:test/test.dart';

void main() {
  group('Feed', () {
    group('fromJson', () {
      test('decodes from JSON', () async {
        final json = await File('test/helpers/fake_feed.json')
            .readAsString()
            .then(jsonDecode);

        expect(Feed.fromJson(json),
            isA<Feed>().having((f) => f.items, 'items', hasLength(50)));
      });
    });
  });
}
