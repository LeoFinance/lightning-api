import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/src/models/models.dart';

part 'community_posts.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityPosts extends Equatable {
  const CommunityPosts({required this.feed, required this.posts});

  factory CommunityPosts.fromJson(Map<String, dynamic> json) {
    return _$CommunityPostsFromJson(json);
  }

  final CommunityFeed feed;
  final List<Post?> posts;

  int get length => posts.length;

  bool get isEmpty => posts.isEmpty;

  bool get isNotEmpty => posts.isNotEmpty;

  Post? operator [](int index) => posts[index];

  CommunityPosts copyWith({
    CommunityFeed? feed,
    List<Post?>? posts,
  }) {
    return CommunityPosts(
      feed: feed ?? this.feed,
      posts: posts ?? this.posts,
    );
  }

  Map<String, dynamic> toJson() => _$CommunityPostsToJson(this);

  // Using just the feed to shallow compare
  @override
  List<Object?> get props => [feed];

  @override
  bool get stringify => true;
}
