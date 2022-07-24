import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/src/models/models.dart';

part 'thread.g.dart';

/// When a thread is displayed, it displays its content, plus the content of
/// its direct children
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Thread extends Equatable {
  const Thread({
    required this.postId,
    required this.content,
    required this.children,
    this.tags = const {},
  });

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);

  /// The post which contains this thread
  @JsonKey(
    fromJson: Authorperm.fromAuthorpermString,
    toJson: Authorperm.toAuthorpermString,
  )
  final Authorperm postId;

  /// The content of this thread
  final Comment content;

  /// The authorperms of the children of this thread in the order returned by
  /// the blockchain
  @JsonKey(
    fromJson: Authorperm.fromListAuthorpermString,
    toJson: Authorperm.toListAuthorpermString,
  )
  final List<Authorperm> children;

  final Set<String> tags;

  Thread copyWith({
    Authorperm? postId,
    Comment? content,
    List<Authorperm>? children,
    Set<String>? tags,
  }) {
    return Thread(
      postId: postId ?? this.postId,
      content: content ?? this.content,
      children: children ?? this.children,
      tags: tags ?? this.tags,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [postId, content, children];

  Map<String, dynamic> toJson() => _$ThreadToJson(this);
}
