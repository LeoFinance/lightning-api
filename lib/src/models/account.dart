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
    required this.lastOwnerUpdateTime,
    required this.lastAccountUpdateTime,
    required this.createdTime,
    required this.postCount,
    required this.canVote,
    required this.upvoteManabar,
    required this.downvoteManabar,
    required this.votingPower,
    required this.balance,
    required this.savingsBalance,
    required this.hbdBalance,
    required this.hbdLastUpdateTime,
    required this.hbdLastInterestPaymentTime,
    required this.savingsHbdBalance,
    required this.savingsHbdLastUpdateTime,
    required this.savingsHbdLastInterestPaymentTime,
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
    required this.nextVestingWithdrawalTime,
    required this.withdrawn,
    required this.toWithdraw,
    required this.withdrawRoutes,
    required this.pendingTransfers,
    required this.curationRewards,
    required this.postingRewards,
    required this.lastPostTime,
    required this.lastRootPostTime,
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
    this.tribeNumEarnedMiningTokens = 0,
    this.tribeNumEarnedOtherTokens = 0,
    this.tribeNumEarnedStakingTokens = 0,
    required this.tribeNumEarnedTokens,
    required this.tribeLastUpvoteTime,
    required this.tribeLastDownvoteTime,
    required this.tribeLastPostTime,
    required this.tribeLastRootPostTime,
    required this.tribeLastWonMiningClaimTime,
    required this.tribeLastWonStakingClaimTime,
    this.tribeIsMuted = false,
    required this.tribeNumPendingTokens,
    required this.tribePrecision,
    required this.tribeStakedMiningPower,
    required this.tribeNumStakedTokens,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  final int id;
  final String name;
  final int reputation;
  final Profile? profile;
  final String jsonMetadata;
  final String postingJsonMetadata;
  final DateTime lastOwnerUpdateTime;
  final DateTime lastAccountUpdateTime;
  final DateTime createdTime;
  final int postCount;
  final bool canVote;
  final Manabar upvoteManabar;
  final Manabar downvoteManabar;
  final int votingPower;
  final double balance;
  final double savingsBalance;
  final double hbdBalance;
  final DateTime hbdLastUpdateTime;
  final DateTime hbdLastInterestPaymentTime;
  final double savingsHbdBalance;
  final DateTime savingsHbdLastUpdateTime;
  final DateTime savingsHbdLastInterestPaymentTime;
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
  final DateTime nextVestingWithdrawalTime;
  final int withdrawn;
  final int toWithdraw;
  final int withdrawRoutes;
  final int pendingTransfers;
  final int curationRewards;
  final int postingRewards;
  final DateTime lastPostTime;
  final DateTime lastRootPostTime;
  final DateTime lastVoteTime;
  final int pendingClaimedAccounts;
  final DateTime governanceVoteExpiration;
  final int openRecurrentTransfers;
  final double vestingBalance;
  final int tribeUpvotePower;
  final int tribeDownvotePower;
  final String tribeSymbol;
  final int tribeNumEarnedMiningTokens;
  final int tribeNumEarnedStakingTokens;
  final int tribeNumEarnedOtherTokens;
  final int tribeNumEarnedTokens;
  final DateTime tribeLastUpvoteTime;
  final DateTime tribeLastDownvoteTime;
  final DateTime tribeLastPostTime;
  final DateTime tribeLastRootPostTime;
  final DateTime tribeLastWonMiningClaimTime;
  final DateTime tribeLastWonStakingClaimTime;
  final bool tribeIsMuted;
  final int tribeNumPendingTokens;
  final int tribePrecision;
  final double tribeStakedMiningPower;
  final int tribeNumStakedTokens;
  final double tribeUpvoteWeightMultiplier;
  final double tribeDownvoteWeightMultiplier;

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
