import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'excerpt.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Excerpt extends Equatable {
  static const EXCERPT_LENGTH = 200;

  final int id;

  final String author;
  final String permlink;
  final String category;
  final String title;

  @JsonKey(fromJson: _extractSummary)
  final String body;

  final JsonMetadata jsonMetadata;

  final DateTime created;
  final DateTime? updated;

  /// The direct children of this content
  final int numChildren;

  final int netRshares;
  final double authorReputation;
  final PostStats stats;
  final String url;
  final List<Beneficiary> beneficiaries;
  final String maxAcceptedPayout;
  final String? community;
  final String? communityTitle;
  final int tribePendingToken;
  final int tribePrecision;
  final String tribeToken;
  final bool tribeIsMuted;
  final double tribeScoreHot;
  final double tribeScorePromoted;
  final double tribeScoreTrend;
  final int tribeTotalPayoutValue;
  final int tribeTotalVoteWeight;
  final int tribeVoteRshares;

  final Map<String, int> upvotes;
  final Map<String, int> downvotes;
  final Map<String, double> tribeUpvotes;
  final Map<String, double> tribeDownvotes;

  static String _extractSummary(String text) {
    final firstSententceMatch = RegExp(r'^.*?\\n');

    final matchParen = RegExp(r'\(.*\)');
    final matchLink = RegExp(r'!?\[.*]]?');
    final matchFullHtml = RegExp(r'<.*?\/.*?>');
    final matchHeader = RegExp(r'#+\s.*?\n');
    final matchTag = RegExp(r'<.*?>');
    final matchUrl = RegExp(r'https?:\/\/[^\s]*');
    final matchMultipleSpaces = RegExp(r'\s\s+');
    final matchPostedTag = RegExp(r'Posted Using.*');

    // Note that the order is important, as we are removing nested items
    final plainText = text
        .replaceAll(matchFullHtml, '')
        .replaceAll(matchParen, '')
        .replaceAll(matchLink, '')
        .replaceAll(matchHeader, '')
        .replaceAll(matchTag, '')
        .replaceAll(matchUrl, '')
        .replaceAll('*', '')
        .replaceAll('---', '')
        .replaceAll('\n', '')
        .replaceAll(matchMultipleSpaces, ' ')
        .replaceAll(matchPostedTag, '')
        .trim();
    final summary = (firstSententceMatch.stringMatch(plainText) ?? plainText)
        .substring(0, EXCERPT_LENGTH);
    return summary;
  }

  Excerpt(
      {required this.id,
      required this.author,
      required this.permlink,
      required this.category,
      required this.title,
      required this.body,
      required this.jsonMetadata,
      required this.created,
      required this.updated,
      required this.numChildren,
      required this.netRshares,
      required this.authorReputation,
      required this.stats,
      required this.url,
      required this.beneficiaries,
      required this.maxAcceptedPayout,
      required this.upvotes,
      required this.downvotes,
      this.community = '',
      this.communityTitle = '',
      required this.tribePendingToken,
      required this.tribePrecision,
      required this.tribeToken,
      required this.tribeIsMuted,
      required this.tribeScoreHot,
      required this.tribeScorePromoted,
      required this.tribeScoreTrend,
      required this.tribeTotalPayoutValue,
      required this.tribeTotalVoteWeight,
      required this.tribeVoteRshares,
      required this.tribeUpvotes,
      required this.tribeDownvotes});

  String get authorperm => '@$author/$permlink';

  factory Excerpt.fromJson(Map<String, dynamic> json) {
    try {
      return _$ExcerptFromJson(json);
    } catch (e, s) {
      print('Failed parsing content $e');
      print(s);
      throw e;
    }
  }

  Map<String, dynamic> toJson() => _$ExcerptToJson(this);

  @override
  List<Object?> get props => [
        id,
        author,
        permlink,
        category,
        title,
        body,
        jsonMetadata,
        created,
        updated,
        numChildren,
        netRshares,
        authorReputation,
        stats,
        url,
        beneficiaries,
        maxAcceptedPayout,
        community,
        communityTitle,
        tribePendingToken,
        tribePrecision,
        tribeToken,
        tribeIsMuted,
        upvotes,
        downvotes
      ];
}
