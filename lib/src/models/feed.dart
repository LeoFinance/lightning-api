import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed.g.dart';

@JsonSerializable(explicitToJson: true)
class Feed extends Equatable {
  final List<String> items;

  Feed(this.items);

  int get length => items.length;

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  operator [](int index) => items[index];

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
  List<Object> get props => [items];

  @override
  String toString() => 'Feed[${items.length}]';
}
