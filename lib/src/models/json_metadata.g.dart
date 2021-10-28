// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMetadata _$JsonMetadataFromJson(Map<String, dynamic> json) => JsonMetadata(
      app: json['app'] as String?,
      format: json['format'] as String? ?? 'markdown',
      canonicalUrl: json['canonical_url'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      links:
          (json['links'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      image: json['image'] ?? const [],
    );

Map<String, dynamic> _$JsonMetadataToJson(JsonMetadata instance) =>
    <String, dynamic>{
      'app': instance.app,
      'format': instance.format,
      'canonical_url': instance.canonicalUrl,
      'tags': instance.tags,
      'links': instance.links,
      'image': instance.image,
    };
