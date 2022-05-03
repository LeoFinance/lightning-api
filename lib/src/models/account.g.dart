// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int,
      name: json['name'] as String,
      reputation: json['reputation'] as int,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      jsonMetadata: json['json_metadata'] as String,
      postingJsonMetadata: json['posting_json_metadata'] as String,
      lastOwnerUpdateTime:
          DateTime.parse(json['last_owner_update_time'] as String),
      lastAccountUpdateTime:
          DateTime.parse(json['last_account_update_time'] as String),
      createdTime: DateTime.parse(json['created_time'] as String),
      postCount: json['post_count'] as int,
      canVote: json['can_vote'] as bool,
      upvoteManabar:
          Manabar.fromJson(json['upvote_manabar'] as Map<String, dynamic>),
      downvoteManabar:
          Manabar.fromJson(json['downvote_manabar'] as Map<String, dynamic>),
      votingPower: json['voting_power'] as int,
      balance: (json['balance'] as num).toDouble(),
      savingsBalance: (json['savings_balance'] as num).toDouble(),
      hbdBalance: (json['hbd_balance'] as num).toDouble(),
      hbdLastUpdateTime: DateTime.parse(json['hbd_last_update_time'] as String),
      hbdLastInterestPaymentTime:
          DateTime.parse(json['hbd_last_interest_payment_time'] as String),
      savingsHbdBalance: (json['savings_hbd_balance'] as num).toDouble(),
      savingsHbdLastUpdateTime:
          DateTime.parse(json['savings_hbd_last_update_time'] as String),
      savingsHbdLastInterestPaymentTime: DateTime.parse(
          json['savings_hbd_last_interest_payment_time'] as String),
      savingsWithdrawRequests: json['savings_withdraw_requests'] as int,
      rewardHbdBalance: (json['reward_hbd_balance'] as num).toDouble(),
      rewardHiveBalance: (json['reward_hive_balance'] as num).toDouble(),
      rewardVestingBalance: (json['reward_vesting_balance'] as num).toDouble(),
      rewardVestingHive: (json['reward_vesting_hive'] as num).toDouble(),
      vestingShares: (json['vesting_shares'] as num).toDouble(),
      delegatedVestingShares:
          (json['delegated_vesting_shares'] as num).toDouble(),
      receivedVestingShares:
          (json['received_vesting_shares'] as num).toDouble(),
      vestingWithdrawRate: (json['vesting_withdraw_rate'] as num).toDouble(),
      postVotingPower: (json['post_voting_power'] as num).toDouble(),
      nextVestingWithdrawalTime:
          DateTime.parse(json['next_vesting_withdrawal_time'] as String),
      withdrawn: json['withdrawn'] as int,
      toWithdraw: json['to_withdraw'] as int,
      withdrawRoutes: json['withdraw_routes'] as int,
      pendingTransfers: json['pending_transfers'] as int,
      curationRewards: json['curation_rewards'] as int,
      postingRewards: json['posting_rewards'] as int,
      lastPostTime: DateTime.parse(json['last_post_time'] as String),
      lastRootPostTime: DateTime.parse(json['last_root_post_time'] as String),
      lastVoteTime: DateTime.parse(json['last_vote_time'] as String),
      pendingClaimedAccounts: json['pending_claimed_accounts'] as int,
      governanceVoteExpiration:
          DateTime.parse(json['governance_vote_expiration'] as String),
      openRecurrentTransfers: json['open_recurrent_transfers'] as int,
      vestingBalance: (json['vesting_balance'] as num).toDouble(),
      tribeSymbol: json['tribe_symbol'] as String,
      tribeUpvoteWeightMultiplier:
          (json['tribe_upvote_weight_multiplier'] as num?)?.toDouble() ?? 1.0,
      tribeDownvoteWeightMultiplier:
          (json['tribe_downvote_weight_multiplier'] as num?)?.toDouble() ?? 1.0,
      tribeUpvotePower: json['tribe_upvote_power'] as int,
      tribeDownvotePower: json['tribe_downvote_power'] as int,
      tribeNumEarnedMiningTokens:
          json['tribe_num_earned_mining_tokens'] as int? ?? 0,
      tribeNumEarnedOtherTokens:
          json['tribe_num_earned_other_tokens'] as int? ?? 0,
      tribeNumEarnedStakingTokens:
          json['tribe_num_earned_staking_tokens'] as int? ?? 0,
      tribeNumEarnedTokens: json['tribe_num_earned_tokens'] as int,
      tribeLastUpvoteTime:
          DateTime.parse(json['tribe_last_upvote_time'] as String),
      tribeLastDownvoteTime:
          DateTime.parse(json['tribe_last_downvote_time'] as String),
      tribeLastPostTime: DateTime.parse(json['tribe_last_post_time'] as String),
      tribeLastRootPostTime:
          DateTime.parse(json['tribe_last_root_post_time'] as String),
      tribeLastWonMiningClaimTime:
          DateTime.parse(json['tribe_last_won_mining_claim_time'] as String),
      tribeLastWonStakingClaimTime:
          DateTime.parse(json['tribe_last_won_staking_claim_time'] as String),
      tribeIsMuted: json['tribe_is_muted'] as bool? ?? false,
      tribeNumPendingTokens: json['tribe_num_pending_tokens'] as int,
      tribePrecision: json['tribe_precision'] as int,
      tribeStakedMiningPower:
          (json['tribe_staked_mining_power'] as num).toDouble(),
      tribeNumStakedTokens: json['tribe_num_staked_tokens'] as int,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reputation': instance.reputation,
      'profile': instance.profile?.toJson(),
      'json_metadata': instance.jsonMetadata,
      'posting_json_metadata': instance.postingJsonMetadata,
      'last_owner_update_time': instance.lastOwnerUpdateTime.toIso8601String(),
      'last_account_update_time':
          instance.lastAccountUpdateTime.toIso8601String(),
      'created_time': instance.createdTime.toIso8601String(),
      'post_count': instance.postCount,
      'can_vote': instance.canVote,
      'upvote_manabar': instance.upvoteManabar.toJson(),
      'downvote_manabar': instance.downvoteManabar.toJson(),
      'voting_power': instance.votingPower,
      'balance': instance.balance,
      'savings_balance': instance.savingsBalance,
      'hbd_balance': instance.hbdBalance,
      'hbd_last_update_time': instance.hbdLastUpdateTime.toIso8601String(),
      'hbd_last_interest_payment_time':
          instance.hbdLastInterestPaymentTime.toIso8601String(),
      'savings_hbd_balance': instance.savingsHbdBalance,
      'savings_hbd_last_update_time':
          instance.savingsHbdLastUpdateTime.toIso8601String(),
      'savings_hbd_last_interest_payment_time':
          instance.savingsHbdLastInterestPaymentTime.toIso8601String(),
      'savings_withdraw_requests': instance.savingsWithdrawRequests,
      'reward_hbd_balance': instance.rewardHbdBalance,
      'reward_hive_balance': instance.rewardHiveBalance,
      'reward_vesting_balance': instance.rewardVestingBalance,
      'reward_vesting_hive': instance.rewardVestingHive,
      'vesting_shares': instance.vestingShares,
      'delegated_vesting_shares': instance.delegatedVestingShares,
      'received_vesting_shares': instance.receivedVestingShares,
      'vesting_withdraw_rate': instance.vestingWithdrawRate,
      'post_voting_power': instance.postVotingPower,
      'next_vesting_withdrawal_time':
          instance.nextVestingWithdrawalTime.toIso8601String(),
      'withdrawn': instance.withdrawn,
      'to_withdraw': instance.toWithdraw,
      'withdraw_routes': instance.withdrawRoutes,
      'pending_transfers': instance.pendingTransfers,
      'curation_rewards': instance.curationRewards,
      'posting_rewards': instance.postingRewards,
      'last_post_time': instance.lastPostTime.toIso8601String(),
      'last_root_post_time': instance.lastRootPostTime.toIso8601String(),
      'last_vote_time': instance.lastVoteTime.toIso8601String(),
      'pending_claimed_accounts': instance.pendingClaimedAccounts,
      'governance_vote_expiration':
          instance.governanceVoteExpiration.toIso8601String(),
      'open_recurrent_transfers': instance.openRecurrentTransfers,
      'vesting_balance': instance.vestingBalance,
      'tribe_upvote_power': instance.tribeUpvotePower,
      'tribe_downvote_power': instance.tribeDownvotePower,
      'tribe_symbol': instance.tribeSymbol,
      'tribe_num_earned_mining_tokens': instance.tribeNumEarnedMiningTokens,
      'tribe_num_earned_staking_tokens': instance.tribeNumEarnedStakingTokens,
      'tribe_num_earned_other_tokens': instance.tribeNumEarnedOtherTokens,
      'tribe_num_earned_tokens': instance.tribeNumEarnedTokens,
      'tribe_last_upvote_time': instance.tribeLastUpvoteTime.toIso8601String(),
      'tribe_last_downvote_time':
          instance.tribeLastDownvoteTime.toIso8601String(),
      'tribe_last_post_time': instance.tribeLastPostTime.toIso8601String(),
      'tribe_last_root_post_time':
          instance.tribeLastRootPostTime.toIso8601String(),
      'tribe_last_won_mining_claim_time':
          instance.tribeLastWonMiningClaimTime.toIso8601String(),
      'tribe_last_won_staking_claim_time':
          instance.tribeLastWonStakingClaimTime.toIso8601String(),
      'tribe_is_muted': instance.tribeIsMuted,
      'tribe_num_pending_tokens': instance.tribeNumPendingTokens,
      'tribe_precision': instance.tribePrecision,
      'tribe_staked_mining_power': instance.tribeStakedMiningPower,
      'tribe_num_staked_tokens': instance.tribeNumStakedTokens,
      'tribe_upvote_weight_multiplier': instance.tribeUpvoteWeightMultiplier,
      'tribe_downvote_weight_multiplier':
          instance.tribeDownvoteWeightMultiplier,
    };
