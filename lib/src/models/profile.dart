import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Profile extends Equatable {
  const Profile({
    this.name,
    this.about,
    this.website,
    this.location,
    this.coverImage,
    this.profileImage,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  final String? name;
  final String? about;
  final String? website;
  final String? location;
  final String? coverImage;
  final String? profileImage;

  Profile copyWith({
    String? name,
    String? about,
    String? website,
    String? location,
    String? coverImage,
    String? profileImage,
  }) =>
      Profile(
        name: name ?? this.name,
        about: about ?? this.about,
        website: website ?? this.website,
        location: location ?? this.location,
        coverImage: coverImage ?? this.coverImage,
        profileImage: profileImage ?? this.profileImage,
      );

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  List<Object?> get props =>
      [name, about, website, location, coverImage, profileImage];
}
