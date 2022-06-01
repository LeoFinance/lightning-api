// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityFeed _$CommunityFeedFromJson(Map<String, dynamic> json) =>
    CommunityFeed(
      posts: Authorperm.deserializeList(json['posts'] as List),
      lastOpIndices: Map<String, int>.from(json['lastOpIndices'] as Map),
      oldestQuery: DateTime.parse(json['oldestQuery'] as String),
    );

Map<String, dynamic> _$CommunityFeedToJson(CommunityFeed instance) =>
    <String, dynamic>{
      'posts': Authorperm.serializeList(instance.posts),
      'lastOpIndices': instance.lastOpIndices,
      'oldestQuery': instance.oldestQuery.toIso8601String(),
    };
