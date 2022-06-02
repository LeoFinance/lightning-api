// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityPosts _$CommunityPostsFromJson(Map<String, dynamic> json) =>
    CommunityPosts(
      feed: CommunityFeed.fromJson(json['feed'] as Map<String, dynamic>),
      posts: (json['posts'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommunityPostsToJson(CommunityPosts instance) =>
    <String, dynamic>{
      'feed': instance.feed.toJson(),
      'posts': instance.posts.map((e) => e?.toJson()).toList(),
    };
