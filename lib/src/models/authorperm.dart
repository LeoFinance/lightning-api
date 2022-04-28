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

  final String author;
  final String permlink;

  Map<String, dynamic> toJson() => _$AuthorpermToJson(this);

  @override
  List<Object?> get props => [author, permlink];

  @override
  String toString() => '@$author/$permlink';
}
