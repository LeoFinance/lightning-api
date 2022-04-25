import 'package:lightning_api/lightning_api.dart';

abstract class Content {
  final int? id;

  final String author;
  final String permlink;
  final String category;
  final String title;
  final String body;
  final int depth;

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

  Content(
      {required this.id,
      required this.author,
      required this.permlink,
      required this.category,
      required this.title,
      required this.body,
      this.depth = 0,
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

  // TODO implement
  bool get isCrossPosted => false;

  // Map<String, String> get activeVotes => {...upvotes, ...downvotes};

  @override
  String toString() => 'Post $authorperm, $numChildren children';

  String get summary {
    final firstSentenceMatch = RegExp(r'^.*?\\n');

    final matchParen = RegExp(r'\(.*\)');
    final matchLink = RegExp(r'!?\[.*]]?');
    final matchFullHtml = RegExp(r'<.*?\/.*?>');
    final matchHeader = RegExp(r'#+\s.*?\n');
    final matchTag = RegExp(r'<.*?>');
    final matchUrl = RegExp(r'https?:\/\/[^\s]*');
    final matchMultipleSpaces = RegExp(r'\s\s+');
    final matchPostedTag = RegExp(r'Posted Using.*');

    // print('_getSummaryText > $value');

    // Note that the order is important, as we are removing nested items
    final plainText = body
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
    // print('  plainText: this.$plainText');
    final summary = (firstSentenceMatch.stringMatch(plainText) ?? plainText);
    // print('_getSummaryText < $summary');
    return summary;
  }

// Is this any better??
// checkIfUpvoted({List? activeVotes, String? username}) async {
//   bool voted = false;
//   String? type;
//   if (activeVotes != null && activeVotes.length > 0) {
//     for (var i = 0; i < activeVotes.length; i++) {
//       if (activeVotes[i]["voter"] == username) {
//         voted = true;
//         if (activeVotes[i]["rshares"].runtimeType == String) {
//           if (num.parse(activeVotes[i]["rshares"]) < 0) {
//             type = "down";
//           }
//         } else {
//           if (activeVotes[i]["rshares"] < 0) {
//             type = "down";
//           }
//         }

//         if (activeVotes[i]["rshares"].runtimeType == String) {
//           if (num.parse(activeVotes[i]["rshares"]) >= 0) {
//             type = "up";
//           }
//         } else {
//           if (activeVotes[i]["rshares"] >= 0) {
//             type = "up";
//           }
//         }

//         break;
//       }
//     }
//   }
//   return {"voted": voted, "type": type};
// }
}
