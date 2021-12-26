// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      name: json['name'] as String?,
      about: json['about'] as String?,
      website: json['website'] as String?,
      location: json['location'] as String?,
      coverImage: json['cover_image'] as String?,
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'name': instance.name,
      'about': instance.about,
      'website': instance.website,
      'location': instance.location,
      'cover_image': instance.coverImage,
      'profile_image': instance.profileImage,
    };
