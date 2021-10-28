import 'dart:convert';
import 'dart:io';

import 'package:lightning_api_models/lightning_api_models.dart';

Future<JsonMetadata> fakeJsonMetadata() async =>
    File('test/helpers/fake_content.json')
        .readAsString()
        .then(jsonDecode)
        .then((json) => JsonMetadata.fromJson(json["json_metadata"]));

Future<Content> fakePost() async => File('test/helpers/fake_content.json')
    .readAsString()
    .then(jsonDecode)
    .then((json) => Content.fromJson(json));

Future<Stats> fakeStats() async => File('test/helpers/fake_content.json')
    .readAsString()
    .then(jsonDecode)
    .then((json) => Stats.fromJson(json["stats"]));

Future<Feed> fakeFeed() async => File('test/helpers/fake_feed.json')
    .readAsString()
    .then(jsonDecode)
    .then((json) => Feed.fromJson(json));
