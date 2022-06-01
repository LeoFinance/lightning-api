import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/src/models/models.dart';

part 'community_feed.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityFeed extends Equatable {
  const CommunityFeed({
    required this.posts,
    required this.lastOpIndices,
    required this.oldestQuery,
  });

  factory CommunityFeed.fromJson(Map<String, dynamic> json) {
    return _$CommunityFeedFromJson(json);
  }

  @JsonKey(
    fromJson: Authorperm.deserializeList,
    toJson: Authorperm.serializeList,
  )
  final List<Authorperm> posts;
  final Map<String, int> lastOpIndices;
  final DateTime oldestQuery;

  int get length => posts.length;

  bool get isEmpty => posts.isEmpty;

  bool get isNotEmpty => posts.isNotEmpty;

  Authorperm operator [](int index) => posts[index];

  CommunityFeed copyWith({
    List<Authorperm>? posts,
    Map<String, int>? lastOpIndices,
    DateTime? oldestQuery,
  }) {
    return CommunityFeed(
      posts: posts ?? this.posts,
      lastOpIndices: lastOpIndices ?? this.lastOpIndices,
      oldestQuery: oldestQuery ?? this.oldestQuery,
    );
  }

  Map<String, dynamic> toJson() => _$CommunityFeedToJson(this);

  @override
  List<Object?> get props => [posts, lastOpIndices, oldestQuery];

  @override
  bool get stringify => true;
}
