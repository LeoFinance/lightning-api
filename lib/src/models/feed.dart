import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/src/models/models.dart';

part 'feed.g.dart';

@JsonSerializable(explicitToJson: true)
class Feed extends Equatable {
  const Feed({
    required this.tag,
    required this.sort,
    this.posts,
    this.comments,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return _$FeedFromJson(json);
  }

  final String tag;
  final String sort;

  @JsonKey(
    fromJson: Authorperm.deserializeNullableList,
    toJson: Authorperm.serializeNullableList,
  )
  final List<Authorperm>? posts;
  @JsonKey(
    fromJson: Authorperm.deserializeNullableList,
    toJson: Authorperm.serializeNullableList,
  )
  final List<Authorperm>? comments;

  int get length => posts?.length ?? comments!.length;

  bool get isEmpty => posts?.isEmpty ?? comments!.isEmpty;
  bool get isNotEmpty => posts?.isNotEmpty ?? comments!.isNotEmpty;

  Authorperm operator [](int index) => posts?[index] ?? comments![index];

  Feed subfeed(int start, [int? end]) {
    return Feed(
      tag: tag,
      sort: sort,
      posts: posts?.sublist(start, end ?? length),
      comments: comments?.sublist(start, end ?? length),
    );
  }

  Feed copyWith({
    String? tag,
    String? sort,
    List<Authorperm>? posts,
    List<Authorperm>? comments,
  }) {
    return Feed(
      tag: tag ?? this.tag,
      sort: sort ?? this.sort,
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toJson() => _$FeedToJson(this);

  @override
  List<Object?> get props => [tag, sort, posts, comments];

  @override
  bool get stringify => true;
}
