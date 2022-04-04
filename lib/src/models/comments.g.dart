// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      parent: Authorperm.fromJson(json['parent'] as Map<String, dynamic>),
      items: (json['items'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Comment.fromJson(e as Map<String, dynamic>)),
      ),
      children: (json['children'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'parent': instance.parent.toJson(),
      'items': instance.items.map((k, e) => MapEntry(k, e.toJson())),
      'children': instance.children,
    };
