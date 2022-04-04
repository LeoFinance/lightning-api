import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'post.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Post {
  final int id;

  final String author;
  final String permlink;
  final String category;
  final String title;
  final String body;

  final JsonMetadata jsonMetadata;

  final DateTime created;
  final DateTime? updated;

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

  Post(
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

  Authorperm get authorperm => Authorperm(author, permlink);

  bool didUpvote(String? username) => upvotes.containsKey(username);
  bool didDownvote(String? username) => downvotes.containsKey(username);
  bool tribeDidUpvote(String? username) => tribeUpvotes.containsKey(username);
  bool tribeDidDownvote(String? username) =>
      tribeDownvotes.containsKey(username);

  factory Post.fromJson(Map<String, dynamic> json) {
    try {
      return _$PostFromJson(json);
    } catch (e, s) {
      print('Failed parsing content $e');
      print(s);
      throw e;
    }
  }

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() => 'Content $title ($authorperm)';
}
