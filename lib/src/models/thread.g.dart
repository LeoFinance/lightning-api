// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thread _$ThreadFromJson(Map<String, dynamic> json) => Thread(
      postId: Authorperm.fromAuthorpermString(json['post_id']),
      content: Comment.fromJson(json['content'] as Map<String, dynamic>),
      children: Authorperm.fromListAuthorpermString(json['children'] as List),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
          const {},
    );

Map<String, dynamic> _$ThreadToJson(Thread instance) => <String, dynamic>{
      'post_id': Authorperm.toAuthorpermString(instance.postId),
      'content': instance.content.toJson(),
      'children': Authorperm.toListAuthorpermString(instance.children),
      'tags': instance.tags.toList(),
    };
