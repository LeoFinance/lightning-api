// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feed _$FeedFromJson(Map<String, dynamic> json) => Feed(
      tag: json['tag'] as String,
      sort: json['sort'] as String,
      posts: Authorperm.deserializeNullableList(json['posts'] as List?),
      comments: Authorperm.deserializeNullableList(json['comments'] as List?),
    );

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'tag': instance.tag,
      'sort': instance.sort,
      'posts': Authorperm.serializeNullableList(instance.posts),
      'comments': Authorperm.serializeNullableList(instance.comments),
    };
