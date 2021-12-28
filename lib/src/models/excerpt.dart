import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'excerpt.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Excerpt extends Content {
  static const EXCERPT_LENGTH = 200;

  Excerpt(
      {required int id,
      required String author,
      required String permlink,
      required String category,
      required String title,
      required String body,
      required int numChildren,
      required JsonMetadata jsonMetadata,
      required DateTime created,
      required DateTime? updated,
      required int netRshares,
      required double authorReputation,
      required PostStats stats,
      required String url,
      required List<Beneficiary> beneficiaries,
      required String maxAcceptedPayout,
      String? community,
      String? communityTitle,
      required int tribePendingToken,
      required int tribePrecision,
      required String tribeToken,
      required bool tribeIsMuted,
      required double tribeScoreHot,
      required double tribeScorePromoted,
      required double tribeScoreTrend,
      required int tribeTotalPayoutValue,
      required int tribeTotalVoteWeight,
      required int tribeVoteRshares,
      required Map<String, int> upvotes,
      required Map<String, int> downvotes,
      required Map<String, double> tribeUpvotes,
      required Map<String, double> tribeDownvotes})
      : super(
            id: id,
            author: author,
            permlink: permlink,
            category: category,
            title: title,
            body: _extractSummary(body),
            jsonMetadata: jsonMetadata,
            created: created,
            updated: updated,
            numChildren: numChildren,
            netRshares: netRshares,
            authorReputation: authorReputation,
            stats: stats,
            url: url,
            beneficiaries: beneficiaries,
            maxAcceptedPayout: maxAcceptedPayout,
            upvotes: upvotes,
            downvotes: downvotes,
            replies: const [],
            community: community,
            communityTitle: communityTitle,
            tribePendingToken: tribePendingToken,
            tribePrecision: tribePrecision,
            tribeToken: tribeToken,
            tribeIsMuted: tribeIsMuted,
            tribeScoreHot: tribeScoreHot,
            tribeScorePromoted: tribeScorePromoted,
            tribeScoreTrend: tribeScoreTrend,
            tribeTotalPayoutValue: tribeTotalPayoutValue,
            tribeTotalVoteWeight: tribeTotalVoteWeight,
            tribeVoteRshares: tribeVoteRshares,
            tribeUpvotes: tribeUpvotes,
            tribeDownvotes: tribeDownvotes);

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

  factory Excerpt.fromPost(Post post) => Excerpt(
      id: post.id,
      author: post.author,
      permlink: post.permlink,
      category: post.category,
      title: post.title,
      body: post.body,
      jsonMetadata: post.jsonMetadata,
      created: post.created,
      updated: post.updated,
      numChildren: post.numChildren,
      netRshares: post.netRshares,
      authorReputation: post.authorReputation,
      stats: post.stats,
      url: post.url,
      beneficiaries: post.beneficiaries,
      maxAcceptedPayout: post.maxAcceptedPayout,
      community: post.community,
      communityTitle: post.communityTitle,
      tribePendingToken: post.tribePendingToken,
      tribePrecision: post.tribePrecision,
      tribeToken: post.tribeToken,
      tribeIsMuted: post.tribeIsMuted,
      tribeScoreHot: post.tribeScoreHot,
      tribeScorePromoted: post.tribeScorePromoted,
      tribeScoreTrend: post.tribeScoreTrend,
      tribeTotalPayoutValue: post.tribeTotalPayoutValue,
      tribeTotalVoteWeight: post.tribeTotalVoteWeight,
      tribeVoteRshares: post.tribeVoteRshares,
      upvotes: post.upvotes,
      downvotes: post.downvotes,
      tribeUpvotes: post.tribeUpvotes,
      tribeDownvotes: post.tribeDownvotes);

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
}
