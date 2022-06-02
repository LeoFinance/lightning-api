// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityFeed _$CommunityFeedFromJson(Map<String, dynamic> json) =>
    CommunityFeed(
      postIds: Authorperm.deserializeList(json['postIds'] as List),
      lastOpIndices: Map<String, int>.from(json['lastOpIndices'] as Map),
      oldestQuery: DateTime.parse(json['oldestQuery'] as String),
    );

Map<String, dynamic> _$CommunityFeedToJson(CommunityFeed instance) =>
    <String, dynamic>{
      'postIds': Authorperm.serializeList(instance.postIds),
      'lastOpIndices': instance.lastOpIndices,
      'oldestQuery': instance.oldestQuery.toIso8601String(),
    };
