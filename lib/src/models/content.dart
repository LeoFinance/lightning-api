import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'content.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Content extends Equatable {
  final int postId;

  final String author;
  final String permlink;
  final String category;
  final String title;
  final String body;

  final String? parentAuthor;
  final String? parentPermlink;

  final JsonMetadata jsonMetadata;

  static DateTime _toUTC(String json) {
    return DateTime.parse(json + (json.endsWith('Z') ? '' : 'Z'));
  }

  static DateTime? _toUTCNullable(String? json) {
    return json != null
        ? DateTime.parse(json + (json.endsWith('Z') ? '' : 'Z'))
        : null;
  }

  @JsonKey(fromJson: _toUTC)
  final DateTime created;
  @JsonKey(fromJson: _toUTCNullable)
  final DateTime? updated;

  final int? depth;
  final int children;

  final int? netRshares;

  final double authorReputation;
  final Stats stats;
  final String url;
  final List<Beneficiary> beneficiaries;
  final String maxAcceptedPayout;
  final String? community;
  final String? communityTitle;
  final String authorperm;
  final int pendingToken;
  final int precision;
  final String token;
  final bool muted;

  final Map<String, String> upvotes;
  final Map<String, String> downvotes;

  final List<Content>? replies;

  @JsonKey(name: 'allComments')
  final List<String> allComments;

  Content(
      {required this.postId,
      required this.author,
      required this.permlink,
      required this.category,
      required this.title,
      required this.body,
      required this.parentAuthor,
      required this.parentPermlink,
      required this.jsonMetadata,
      required this.created,
      required this.updated,
      required this.depth,
      required this.children,
      required this.netRshares,
      required this.authorReputation,
      required this.stats,
      required this.url,
      required this.beneficiaries,
      required this.maxAcceptedPayout,
      this.community,
      this.communityTitle,
      required this.authorperm,
      required this.pendingToken,
      required this.precision,
      required this.token,
      required this.muted,
      required this.upvotes,
      required this.downvotes,
      required this.replies,
      required this.allComments});

  factory Content.fromJson(Map<String, dynamic> json) {
    try {
      return _$ContentFromJson(json);
    } catch (e, s) {
      print('Failed parsing content $e');
      print(s);
      throw e;
    }
  }

  Map<String, dynamic> toJson() => _$ContentToJson(this);

  @override
  List<Object?> get props => [
        postId,
        author,
        permlink,
        category,
        title,
        body,
        jsonMetadata,
        created,
        updated,
        depth,
        children,
        netRshares,
        authorReputation,
        stats,
        url,
        beneficiaries,
        maxAcceptedPayout,
        community,
        communityTitle,
        authorperm,
        pendingToken,
        precision,
        token,
        muted,
        upvotes,
        downvotes,
        replies,
        allComments
      ];
}
