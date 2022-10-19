import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:leofinance_lightning_api/src/models/models.dart';

part 'community_feed.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunityFeed extends Equatable {
  const CommunityFeed({
    required this.postIds,
    required this.lastOpIndices,
    required this.oldestQuery,
  });

  factory CommunityFeed.fromJson(Map<String, dynamic> json) {
    return _$CommunityFeedFromJson(json);
  }

  @JsonKey(
    fromJson: Authorperm.deserializeList,
    toJson: Authorperm.serializeList,
  )
  final List<Authorperm> postIds;
  final Map<String, int> lastOpIndices;
  final DateTime oldestQuery;

  int get length => postIds.length;

  bool get isEmpty => postIds.isEmpty;

  bool get isNotEmpty => postIds.isNotEmpty;

  Authorperm operator [](int index) => postIds[index];

  CommunityFeed copyWith({
    List<Authorperm>? postIds,
    Map<String, int>? lastOpIndices,
    DateTime? oldestQuery,
  }) {
    return CommunityFeed(
      postIds: postIds ?? this.postIds,
      lastOpIndices: lastOpIndices ?? this.lastOpIndices,
      oldestQuery: oldestQuery ?? this.oldestQuery,
    );
  }

  Map<String, dynamic> toJson() => _$CommunityFeedToJson(this);

  @override
  List<Object?> get props => [postIds, lastOpIndices, oldestQuery];

  @override
  bool get stringify => true;
}
