// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      id: json['id'] as int,
      author: json['author'] as String,
      permlink: json['permlink'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      parentAuthor: json['parent_author'] as String?,
      parentPermlink: json['parent_permlink'] as String?,
      depth: json['depth'] as int? ?? 0,
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      jsonMetadata:
          JsonMetadata.fromJson(json['json_metadata'] as Map<String, dynamic>),
      created: DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
      numChildren: json['num_children'] as int,
      netRshares: json['net_rshares'] as int,
      authorReputation: (json['author_reputation'] as num).toDouble(),
      stats: PostStats.fromJson(json['stats'] as Map<String, dynamic>),
      url: json['url'] as String,
      beneficiaries: (json['beneficiaries'] as List<dynamic>)
          .map((e) => Beneficiary.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxAcceptedPayout: json['max_accepted_payout'] as String,
      upvotes: Map<String, int>.from(json['upvotes'] as Map),
      downvotes: Map<String, int>.from(json['downvotes'] as Map),
      community: json['community'] as String? ?? '',
      communityTitle: json['community_title'] as String? ?? '',
      tribePendingToken: json['tribe_pending_token'] as int,
      tribePrecision: json['tribe_precision'] as int,
      tribeToken: json['tribe_token'] as String,
      tribeIsMuted: json['tribe_is_muted'] as bool,
      tribeScoreHot: (json['tribe_score_hot'] as num).toDouble(),
      tribeScorePromoted: (json['tribe_score_promoted'] as num).toDouble(),
      tribeScoreTrend: (json['tribe_score_trend'] as num).toDouble(),
      tribeTotalPayoutValue: json['tribe_total_payout_value'] as int,
      tribeTotalVoteWeight: json['tribe_total_vote_weight'] as int,
      tribeVoteRshares: json['tribe_vote_rshares'] as int,
      tribeUpvotes: (json['tribe_upvotes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      tribeDownvotes: (json['tribe_downvotes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'permlink': instance.permlink,
      'category': instance.category,
      'title': instance.title,
      'body': instance.body,
      'parent_author': instance.parentAuthor,
      'parent_permlink': instance.parentPermlink,
      'depth': instance.depth,
      'replies': instance.replies,
      'json_metadata': instance.jsonMetadata.toJson(),
      'created': instance.created.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
      'num_children': instance.numChildren,
      'net_rshares': instance.netRshares,
      'author_reputation': instance.authorReputation,
      'stats': instance.stats.toJson(),
      'url': instance.url,
      'beneficiaries': instance.beneficiaries.map((e) => e.toJson()).toList(),
      'max_accepted_payout': instance.maxAcceptedPayout,
      'community': instance.community,
      'community_title': instance.communityTitle,
      'tribe_pending_token': instance.tribePendingToken,
      'tribe_precision': instance.tribePrecision,
      'tribe_token': instance.tribeToken,
      'tribe_is_muted': instance.tribeIsMuted,
      'tribe_score_hot': instance.tribeScoreHot,
      'tribe_score_promoted': instance.tribeScorePromoted,
      'tribe_score_trend': instance.tribeScoreTrend,
      'tribe_total_payout_value': instance.tribeTotalPayoutValue,
      'tribe_total_vote_weight': instance.tribeTotalVoteWeight,
      'tribe_vote_rshares': instance.tribeVoteRshares,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
      'tribe_upvotes': instance.tribeUpvotes,
      'tribe_downvotes': instance.tribeDownvotes,
    };
