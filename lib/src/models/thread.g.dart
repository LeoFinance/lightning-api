// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thread _$ThreadFromJson(Map<String, dynamic> json) => Thread(
      parent: Authorperm.fromAuthorpermString(json['parent']),
      replies: json['replies'] == null
          ? const []
          : Authorperm.fromListAuthorpermString(json['replies'] as List),
    );

Map<String, dynamic> _$ThreadToJson(Thread instance) => <String, dynamic>{
      'parent': Authorperm.toAuthorpermString(instance.parent),
      'replies': Authorperm.toListAuthorpermString(instance.replies),
    };
