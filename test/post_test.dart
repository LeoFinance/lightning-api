import 'dart:convert';
import 'dart:io';
import 'package:lightning_api_models/lightning_api_models.dart';
import 'package:test/test.dart';

void main() {
  group('Content', () {
    group('fromJson', () {
      test('decodes from JSON', () async {
        final json = await File('test/helpers/fake_content.json')
            .readAsString()
            .then(jsonDecode);

        expect(Content.fromJson(json),
            isA<Content>().having((c) => c.beneficiaries, 'beneficiaries', []));
      });

      test('allows empty beneficiaries', () async {
        final json = await File('test/helpers/fake_content.json')
            .readAsString()
            .then(jsonDecode);
        json["beneficiaries"] = [];

        expect(Content.fromJson(json),
            isA<Content>().having((c) => c.beneficiaries, 'beneficiaries', []));
      });
    });
  });
}
