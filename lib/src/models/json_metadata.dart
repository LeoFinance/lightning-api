import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_metadata.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class JsonMetadata extends Equatable {
  final String? app;
  final String format;
  final String? canonicalUrl;
  final List<String> tags;
  final List<String> links;

  // Might be a String or a list of Strings
  final dynamic image;

  JsonMetadata(
      {this.app,
      this.format = 'markdown',
      this.canonicalUrl,
      this.tags = const [],
      this.links = const [],
      this.image = const []});

  factory JsonMetadata.fromJson(Map<String, dynamic> json) =>
      _$JsonMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMetadataToJson(this);

  @override
  List<Object?> get props => [app, format, tags, links, image];

  @override
  bool get stringify => true;
}
