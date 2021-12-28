import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'comment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Comment extends Content {
  Comment(
      {required int id,
      required String author,
      required String permlink,
      required String category,
      required String title,
      required String body,
      required this.parentAuthor,
      required this.parentPermlink,
      required this.depth,
      required int numChildren,
      required List<Comment> replies,
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
            body: body,
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
            replies: replies,
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

  final String parentAuthor;
  final String parentPermlink;
  final int depth;

  String get authorperm => '@$author/$permlink';

  factory Comment.fromJson(Map<String, dynamic> json) {
    try {
      return _$CommentFromJson(json);
    } catch (e, s) {
      print('Failed parsing content $e');
      print(s);
      throw e;
    }
  }

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  List<Object?> get props => [
        ...super.props,
        parentAuthor,
        parentPermlink,
        depth,
      ];
}
