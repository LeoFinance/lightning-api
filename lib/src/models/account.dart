import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/src/models/models.dart';

part 'account.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Account {
  const Account({
    required this.id,
    required this.name,
    required this.reputation,
    required this.profile,
    required this.jsonMetadata,
    required this.postingJsonMetadata,
    required this.lastOwnerUpdate,
    required this.lastAccountUpdate,
    required this.created,
    required this.postCount,
    required this.canVote,
    required this.upvoteManabar,
    required this.downvoteManabar,
    required this.votingPower,
    required this.balance,
    required this.savingsBalance,
    required this.hbdBalance,
    required this.hbdLastUpdate,
    required this.hbdLastInterestPayment,
    required this.savingsHbdBalance,
    required this.savingsHbdLastUpdate,
    required this.savingsHbdLastInterestPayment,
    required this.savingsWithdrawRequests,
    required this.rewardHbdBalance,
    required this.rewardHiveBalance,
    required this.rewardVestingBalance,
    required this.rewardVestingHive,
    required this.vestingShares,
    required this.delegatedVestingShares,
    required this.receivedVestingShares,
    required this.vestingWithdrawRate,
    required this.postVotingPower,
    required this.nextVestingWithdrawal,
    required this.withdrawn,
    required this.toWithdraw,
    required this.withdrawRoutes,
    required this.pendingTransfers,
    required this.curationRewards,
    required this.postingRewards,
    required this.lastPost,
    required this.lastRootPost,
    required this.lastVoteTime,
    required this.pendingClaimedAccounts,
    required this.governanceVoteExpiration,
    required this.openRecurrentTransfers,
    required this.vestingBalance,
    required this.tribeSymbol,
    this.tribeUpvoteWeightMultiplier = 1.0,
    this.tribeDownvoteWeightMultiplier = 1.0,
    required this.tribeUpvotePower,
    required this.tribeDownvotePower,
    this.tribeEarnedMiningToken = 0,
    this.tribeEarnedOtherToken = 0,
    this.tribeEarnedStakingToken = 0,
    required this.tribeEarnedToken,
    required this.tribeLastUpvoteTime,
    required this.tribeLastDownvoteTime,
    required this.tribeLastPostTime,
    required this.tribeLastRootPostTime,
    required this.tribeLastWonMiningClaim,
    required this.tribeLastWonStakingClaim,
    this.tribeIsMuted = false,
    required this.tribePendingToken,
    required this.tribePrecision,
    required this.tribeStakedMiningPower,
    required this.tribeStakedTokens,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  final int id;
  final String name;
  final int reputation;
  final Profile? profile;
  final String jsonMetadata;
  final String postingJsonMetadata;
  final DateTime lastOwnerUpdate;
  final DateTime lastAccountUpdate;
  final DateTime created;
  final int postCount;
  final bool canVote;
  final Manabar upvoteManabar;
  final Manabar downvoteManabar;
  final int votingPower;
  final double balance;
  final double savingsBalance;
  final double hbdBalance;
  final DateTime hbdLastUpdate;
  final DateTime hbdLastInterestPayment;
  final double savingsHbdBalance;
  final DateTime savingsHbdLastUpdate;
  final DateTime savingsHbdLastInterestPayment;
  final int savingsWithdrawRequests;
  final double rewardHbdBalance;
  final double rewardHiveBalance;
  final double rewardVestingBalance;
  final double rewardVestingHive;
  final double vestingShares;
  final double delegatedVestingShares;
  final double receivedVestingShares;
  final double vestingWithdrawRate;
  final double postVotingPower;
  final DateTime nextVestingWithdrawal;
  final int withdrawn;
  final int toWithdraw;
  final int withdrawRoutes;
  final int pendingTransfers;
  final int curationRewards;
  final int postingRewards;
  final DateTime lastPost;
  final DateTime lastRootPost;
  final DateTime lastVoteTime;
  final int pendingClaimedAccounts;
  final DateTime governanceVoteExpiration;
  final int openRecurrentTransfers;
  final double vestingBalance;
  final int tribeUpvotePower;
  final int tribeDownvotePower;
  final String tribeSymbol;
  final int tribeEarnedMiningToken;
  final int tribeEarnedStakingToken;
  final int tribeEarnedOtherToken;
  final int tribeEarnedToken;
  final DateTime tribeLastUpvoteTime;
  final DateTime tribeLastDownvoteTime;
  final DateTime tribeLastPostTime;
  final DateTime tribeLastRootPostTime;
  final DateTime tribeLastWonMiningClaim;
  final DateTime tribeLastWonStakingClaim;
  final bool tribeIsMuted;
  final int tribePendingToken;
  final int tribePrecision;
  final double tribeStakedMiningPower;
  final int tribeStakedTokens;
  final double tribeUpvoteWeightMultiplier;
  final double tribeDownvoteWeightMultiplier;

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
