import 'package:json_annotation/json_annotation.dart';
import 'package:leofinance_lightning_api/src/models/models.dart';

part 'post.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Post extends Content {
  const Post({
    required int id,
    required String author,
    required String permlink,
    required String category,
    required String title,
    required String body,
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
          depth: 0,
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

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() => 'Post $title ($authorperm)';
}
