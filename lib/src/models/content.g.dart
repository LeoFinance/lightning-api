// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      postId: json['post_id'] as int,
      author: json['author'] as String,
      permlink: json['permlink'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      parentAuthor: json['parent_author'] as String?,
      parentPermlink: json['parent_permlink'] as String?,
      jsonMetadata:
          JsonMetadata.fromJson(json['json_metadata'] as Map<String, dynamic>),
      created: Content._toUTC(json['created'] as String),
      updated: Content._toUTCNullable(json['updated'] as String?),
      depth: json['depth'] as int?,
      children: json['children'] as int,
      netRshares: json['net_rshares'] as int?,
      authorReputation: (json['author_reputation'] as num).toDouble(),
      stats: Stats.fromJson(json['stats'] as Map<String, dynamic>),
      url: json['url'] as String,
      beneficiaries: (json['beneficiaries'] as List<dynamic>)
          .map((e) => Beneficiary.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxAcceptedPayout: json['max_accepted_payout'] as String,
      community: json['community'] as String?,
      communityTitle: json['community_title'] as String?,
      authorperm: json['authorperm'] as String,
      pendingToken: json['pending_token'] as int,
      precision: json['precision'] as int,
      token: json['token'] as String,
      muted: json['muted'] as bool,
      upvotes: Map<String, String>.from(json['upvotes'] as Map),
      downvotes: Map<String, String>.from(json['downvotes'] as Map),
      replies:
          (json['replies'] as List<dynamic>).map((e) => e as String).toList(),
      allComments: (json['allComments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'post_id': instance.postId,
      'author': instance.author,
      'permlink': instance.permlink,
      'category': instance.category,
      'title': instance.title,
      'body': instance.body,
      'parent_author': instance.parentAuthor,
      'parent_permlink': instance.parentPermlink,
      'json_metadata': instance.jsonMetadata.toJson(),
      'created': instance.created.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
      'depth': instance.depth,
      'children': instance.children,
      'net_rshares': instance.netRshares,
      'author_reputation': instance.authorReputation,
      'stats': instance.stats.toJson(),
      'url': instance.url,
      'beneficiaries': instance.beneficiaries.map((e) => e.toJson()).toList(),
      'max_accepted_payout': instance.maxAcceptedPayout,
      'community': instance.community,
      'community_title': instance.communityTitle,
      'authorperm': instance.authorperm,
      'pending_token': instance.pendingToken,
      'precision': instance.precision,
      'token': instance.token,
      'muted': instance.muted,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
      'replies': instance.replies,
      'allComments': instance.allComments,
    };
