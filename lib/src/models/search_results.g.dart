// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResults _$SearchResultsFromJson(Map<String, dynamic> json) =>
    SearchResults(
      json['num_results'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      query: json['query'] as String,
    );

Map<String, dynamic> _$SearchResultsToJson(SearchResults instance) =>
    <String, dynamic>{
      'query': instance.query,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'num_results': instance.numResults,
    };

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      Authorperm.fromJson(json['authorperm'] as Map<String, dynamic>),
      score: (json['score'] as num).toDouble(),
      summary: json['summary'] as String,
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'authorperm': instance.authorperm.toJson(),
      'score': instance.score,
      'summary': instance.summary,
    };
