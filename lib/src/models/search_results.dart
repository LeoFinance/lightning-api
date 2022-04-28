import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/lightning_api.dart';

part 'search_results.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SearchResults extends Equatable {
  const SearchResults(this.numResults, this.results, {required this.query});

  factory SearchResults.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsFromJson(json);

  final String query;
  final List<SearchResult> results;
  final int numResults;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [query, numResults, results];

  Map<String, dynamic> toJson() => _$SearchResultsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SearchResult extends Equatable {
  const SearchResult(
    this.authorperm, {
    required this.score,
    required this.summary,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  final Authorperm authorperm;
  final double score;
  final String summary;

  @override
  List<Object?> get props => [authorperm, score];

  @override
  bool get stringify => true;

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
