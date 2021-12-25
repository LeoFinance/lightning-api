import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

// @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
// class Profile extends Equatable {
//   Profile({
//     required this.id,
//     required this.name,
//     required this.created,
//     required this.active,
//     required this.postCount,
//     required this.reputation,
//     required this.blacklists,
//     required this.stats,
//     required this.metadata,
//   });

//   final int id;
//   final String name;
//   final DateTime created;
//   final DateTime active;
//   final int postCount;
//   final double reputation;
//   final List<dynamic> blacklists;
//   final ProfileStats stats;
//   final ProfileMetadataWrapper metadata;

//   factory Profile.fromJson(Map<String, dynamic> json) =>
//       _$ProfileFromJson(json);

//   Map<String, dynamic> toJson() => _$ProfileToJson(this);

//   Profile copyWith({
//     int? id,
//     String? name,
//     DateTime? created,
//     DateTime? active,
//     int? postCount,
//     double? reputation,
//     List<dynamic>? blacklists,
//     ProfileStats? stats,
//     ProfileMetadataWrapper? metadata,
//   }) =>
//       Profile(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         created: created ?? this.created,
//         active: active ?? this.active,
//         postCount: postCount ?? this.postCount,
//         reputation: reputation ?? this.reputation,
//         blacklists: blacklists ?? this.blacklists,
//         stats: stats ?? this.stats,
//         metadata: metadata ?? this.metadata,
//       );

//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         created,
//         active,
//         postCount,
//         reputation,
//         blacklists,
//         stats,
//         metadata
//       ];
// }

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProfileWrapper extends Equatable {
  ProfileWrapper({
    required this.profile,
  });

  final Profile profile;

  factory ProfileWrapper.fromJson(Map<String, dynamic> json) =>
      _$ProfileWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileWrapperToJson(this);

  @override
  List<Object?> get props => [profile];
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Profile extends Equatable {
  Profile({
    required this.name,
    required this.about,
    this.website,
    required this.location,
    this.coverImage,
    required this.profileImage,
    this.blacklistDescription,
    this.mutedListDescription,
  });

  final String name;
  final String about;
  final String? website;
  final String location;
  final String? coverImage;
  final String profileImage;
  final String? blacklistDescription;
  final String? mutedListDescription;

  Profile copyWith({
    String? name,
    String? about,
    String? website,
    String? location,
    String? coverImage,
    String? profileImage,
    String? blacklistDescription,
    String? mutedListDescription,
  }) =>
      Profile(
        name: name ?? this.name,
        about: about ?? this.about,
        website: website ?? this.website,
        location: location ?? this.location,
        coverImage: coverImage ?? this.coverImage,
        profileImage: profileImage ?? this.profileImage,
        blacklistDescription: blacklistDescription ?? this.blacklistDescription,
        mutedListDescription: mutedListDescription ?? this.mutedListDescription,
      );

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  List<Object?> get props => [
        name,
        about,
        website,
        location,
        coverImage,
        profileImage,
        blacklistDescription,
        mutedListDescription
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProfileStats extends Equatable {
  ProfileStats({
    required this.rank,
    required this.following,
    required this.followers,
  });

  final int rank;
  final int following;
  final int followers;

  ProfileStats copyWith({
    int? rank,
    int? following,
    int? followers,
  }) =>
      ProfileStats(
        rank: rank ?? this.rank,
        following: following ?? this.following,
        followers: followers ?? this.followers,
      );

  factory ProfileStats.fromJson(Map<String, dynamic> json) =>
      _$ProfileStatsFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileStatsToJson(this);

  @override
  List<Object?> get props => [rank, following, followers];
}
