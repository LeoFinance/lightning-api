// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      parentAuthor: json['parent_author'] as String,
      parentPermlink: json['parent_permlink'] as String,
      items: (json['items'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Content.fromJson(e as Map<String, dynamic>)),
      ),
      children: (json['children'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'parent_author': instance.parentAuthor,
      'parent_permlink': instance.parentPermlink,
      'items': instance.items.map((k, e) => MapEntry(k, e.toJson())),
      'children': instance.children,
    };
