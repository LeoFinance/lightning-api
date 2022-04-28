import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/src/models/models.dart';

part 'comment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Comment extends Content {
  const Comment({
    required int id,
    required String author,
    required String permlink,
    required String category,
    required String title,
    required String body,
    required this.parentAuthor,
    required this.parentPermlink,
    required int depth,
    required JsonMetadata jsonMetadata,
    required DateTime created,
    required DateTime updated,
    required int numChildren,
    required int netRshares,
    required double authorReputation,
    required PostStats stats,
    required String url,
    required List<Beneficiary> beneficiaries,
    required String maxAcceptedPayout,
    required Map<String, int> upvotes,
    required Map<String, int> downvotes,
    String community = '',
    String communityTitle = '',
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
    required Map<String, double> tribeUpvotes,
    required Map<String, double> tribeDownvotes,
  }) : super(
          id: id,
          author: author,
          permlink: permlink,
          category: category,
          title: title,
          body: body,
          jsonMetadata: jsonMetadata,
          depth: depth,
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
          community: community,
          communityTitle: communityTitle,
          tribeUpvotes: tribeUpvotes,
          tribeDownvotes: tribeDownvotes,
        );

  factory Comment.fromJson(Map<String, dynamic> json) {
    return _$CommentFromJson(json);
  }

  final String parentAuthor;
  final String parentPermlink;

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  String toString() => 'Content $title ($authorperm)';
}
