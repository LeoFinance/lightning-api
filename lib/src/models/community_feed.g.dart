// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityFeed _$CommunityFeedFromJson(Map<String, dynamic> json) =>
    CommunityFeed(
      posts: Authorperm.deserializeList(json['posts'] as List),
      lastOpIndex: Map<String, int>.from(json['lastOpIndex'] as Map),
    );

Map<String, dynamic> _$CommunityFeedToJson(CommunityFeed instance) =>
    <String, dynamic>{
      'posts': Authorperm.serializeList(instance.posts),
      'lastOpIndex': instance.lastOpIndex,
    };
