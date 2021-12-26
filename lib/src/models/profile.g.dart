// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileWrapper _$ProfileWrapperFromJson(Map<String, dynamic> json) =>
    ProfileWrapper(
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileWrapperToJson(ProfileWrapper instance) =>
    <String, dynamic>{
      'profile': instance.profile.toJson(),
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      name: json['name'] as String,
      about: json['about'] as String,
      website: json['website'] as String?,
      location: json['location'] as String?,
      coverImage: json['cover_image'] as String?,
      profileImage: json['profile_image'] as String,
      blacklistDescription: json['blacklist_description'] as String?,
      mutedListDescription: json['muted_list_description'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'name': instance.name,
      'about': instance.about,
      'website': instance.website,
      'location': instance.location,
      'cover_image': instance.coverImage,
      'profile_image': instance.profileImage,
      'blacklist_description': instance.blacklistDescription,
      'muted_list_description': instance.mutedListDescription,
    };

ProfileStats _$ProfileStatsFromJson(Map<String, dynamic> json) => ProfileStats(
      rank: json['rank'] as int,
      following: json['following'] as int,
      followers: json['followers'] as int,
    );

Map<String, dynamic> _$ProfileStatsToJson(ProfileStats instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'following': instance.following,
      'followers': instance.followers,
    };
