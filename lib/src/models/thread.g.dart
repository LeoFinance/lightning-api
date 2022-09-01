// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thread _$ThreadFromJson(Map<String, dynamic> json) => Thread(
      authorperm:
          Authorperm.fromJson(json['authorperm'] as Map<String, dynamic>),
      parent: Comment.fromJson(json['parent'] as Map<String, dynamic>),
      replies: json['replies'] == null
          ? const []
          : Authorperm.fromListAuthorpermString(json['replies'] as List),
    );

Map<String, dynamic> _$ThreadToJson(Thread instance) => <String, dynamic>{
      'authorperm': instance.authorperm.toJson(),
      'parent': instance.parent.toJson(),
      'replies': Authorperm.toListAuthorpermString(instance.replies),
    };
