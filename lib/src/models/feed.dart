import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/src/models/models.dart';

part 'feed.g.dart';

@JsonSerializable(explicitToJson: true)
class Feed extends Equatable {
  const Feed({required this.tag, required this.sort, required this.posts});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return _$FeedFromJson(json);
  }

  final String tag;
  final String sort;

  @JsonKey(
      fromJson: Authorperm.deserializeList,
      toJson: Authorperm.serializeList,
  )
  final List<Authorperm> posts;

  int get length => posts.length;

  bool get isEmpty => posts.isEmpty;
  bool get isNotEmpty => posts.isNotEmpty;

  Authorperm operator [](int index) => posts[index];

  Feed copyWith({String? tag, String? sort, List<Authorperm>? posts}) {
    return Feed(
      tag: tag ?? this.tag,
      sort: sort ?? this.sort,
      posts: posts ?? this.posts,
    );
  }

  Map<String, dynamic> toJson() => _$FeedToJson(this);

  @override
  List<Object?> get props => [tag, sort, posts];

  @override
  bool get stringify => true;
}
