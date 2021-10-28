import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import "content.dart";

part 'feed.g.dart';

@JsonSerializable(explicitToJson: true)
class Feed extends Equatable {
  final List<Content> items;

  Feed({this.items = const []});

  factory Feed.fromJson(List<dynamic> json) {
    return Feed(
        items: json
            .where((j) => j.isNotEmpty)
            .map((j) => Content.fromJson(j))
            .toList());
  }

  Map<String, dynamic> toJson() => _$FeedToJson(this);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Feed[${items.length}]';
}
