import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:lightning_api/lightning_api.dart';

part 'search_results.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SearchResults extends Equatable {
  final String query;
  final List<SearchResult> results;
  final int numResults;

  const SearchResults(this.numResults, this.results, {required this.query});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [query, numResults, results];

  factory SearchResults.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SearchResult extends Equatable {
  final Authorperm authorperm;
  final double score;
  final String summary;

  const SearchResult(this.authorperm,
      {required this.score, required this.summary});

  @override
  List<Object?> get props => [authorperm, score];

  @override
  bool get stringify => true;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
