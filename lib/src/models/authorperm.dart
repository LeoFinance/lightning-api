import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authorperm.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Authorperm extends Equatable {
  const Authorperm(this.author, this.permlink);

  factory Authorperm.fromJson(Map<String, dynamic> json) =>
      _$AuthorpermFromJson(json);

  factory Authorperm.parse(String authorperm) {
    final parts = authorperm.split('/');
    return Authorperm(
      parts[0].startsWith('@') ? parts[0].substring(1) : parts[0],
      parts[1],
    );
  }

  // ignore: prefer_constructors_over_static_methods
  static Authorperm fromAuthorpermString(dynamic ap) =>
      Authorperm.parse(ap.toString());
  static String toAuthorpermString(Authorperm ap) => ap.toString();
  static List<Authorperm> fromListAuthorpermString(List<dynamic> aps) =>
      aps.map(fromAuthorpermString).toList();
  static List<String> toListAuthorpermString(List<Authorperm> aps) =>
      aps.map(toAuthorpermString).toList();

  static List<Authorperm> deserializeList(List posts) =>
      posts.map((dynamic s) => Authorperm.parse(s as String)).toList();

  static List<String> serializeList(List<Authorperm> posts) =>
      posts.map((p) => p.toString()).toList();

  static List<Authorperm>? deserializeNullableList(List? posts) =>
      posts?.map((dynamic s) => Authorperm.parse(s as String)).toList();

  static List<String>? serializeNullableList(List<Authorperm>? posts) =>
      posts?.map((p) => p.toString()).toList();

  final String author;
  final String permlink;

  Map<String, dynamic> toJson() => _$AuthorpermToJson(this);

  @override
  List<Object?> get props => [author, permlink];

  @override
  String toString() => '@$author/$permlink';
}
