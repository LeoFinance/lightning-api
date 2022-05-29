import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/src/models/models.dart';

part 'community_feed.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityFeed extends Equatable {
  const CommunityFeed({required this.posts, required this.lastOpIndex});

  factory CommunityFeed.fromJson(Map<String, dynamic> json) {
    return _$CommunityFeedFromJson(json);
  }

  @JsonKey(
    fromJson: Authorperm.deserializeList,
    toJson: Authorperm.serializeList,
  )
  final List<Authorperm> posts;
  final Map<String, int> lastOpIndex;

  int get length => posts.length;

  bool get isEmpty => posts.isEmpty;

  bool get isNotEmpty => posts.isNotEmpty;

  Authorperm operator [](int index) => posts[index];

  CommunityFeed copyWith({
    List<Authorperm>? posts,
    Map<String, int>? lastOpIndex,
  }) {
    return CommunityFeed(
      posts: posts ?? this.posts,
      lastOpIndex: lastOpIndex ?? this.lastOpIndex,
    );
  }

  Map<String, dynamic> toJson() => _$CommunityFeedToJson(this);

  @override
  List<Object?> get props => [posts, lastOpIndex];

  @override
  bool get stringify => true;
}
