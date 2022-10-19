import 'dart:convert';
import 'dart:io';
import 'package:leofinance_lightning_api/lightning_api.dart';
import 'package:test/test.dart';

void main() {
  group('Post', () {
    group('fromJson', () {
      test('decodes from JSON', () async {
        final s = await File('test/samples/post.json').readAsString();
        final j = jsonDecode(s) as Map<String, dynamic>;

        expect(
          Post.fromJson(j),
          isA<Post>()
              .having((c) => c.beneficiaries, 'beneficiaries', <Beneficiary>[]),
        );
      });

      test('allows empty beneficiaries', () async {
        final s = await File('test/samples/post.json').readAsString();
        final json = jsonDecode(s) as Map<String, dynamic>;

        json['beneficiaries'] = <Beneficiary>[];

        expect(
          Post.fromJson(json),
          isA<Post>().having(
            (c) => c.beneficiaries,
            'beneficiaries',
            <Beneficiary>[],
          ),
        );
      });
    });
  });
}
