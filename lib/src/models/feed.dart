import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'feed.g.dart';

@JsonSerializable(explicitToJson: true)
class Feed extends Equatable {
  final List<String> posts;

  Feed(this.posts);

  int get length => posts.length;

  bool get isEmpty => posts.isEmpty;
  bool get isNotEmpty => posts.isNotEmpty;

  Authorperm operator [](int index) => Authorperm.parse(posts[index]);

  // factory Feed.fromJson(List<dynamic> json) {
  //   return Feed(json
  //       .where((j) => j.isNotEmpty)
  //       .map((j) => Excerpt.fromJson(j))
  //       .toList());
  // }

  factory Feed.fromJson(Map<String, dynamic> json) {
    try {
      return _$FeedFromJson(json);
    } catch (e, s) {
      print('Failed parsing content $e');
      print(s);
      throw e;
    }
  }

  Map<String, dynamic> toJson() => _$FeedToJson(this);

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'Feed: $posts';
}
