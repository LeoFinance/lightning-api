import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed.g.dart';

@JsonSerializable(explicitToJson: true)
class Feed extends Equatable {
  final String tag;
  final String sort;
  final List<String> posts;

  Feed({required this.tag, required this.sort, required this.posts});

  int get length => posts.length;

  bool get isEmpty => posts.isEmpty;
  bool get isNotEmpty => posts.isNotEmpty;

  String operator [](int index) => posts[index];

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
  List<Object> get props => [tag, sort, posts];

  @override
  String toString() => 'Feed: $posts';
}
