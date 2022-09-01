import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lightning_api/src/models/models.dart';

part 'thread.g.dart';

/// When a thread is displayed, it displays its content, plus the content of
/// its direct children
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Thread extends Equatable {
  const Thread({
    required this.authorperm,
    required this.parent,
    this.replies = const [],
  });

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);

  final Authorperm authorperm;
  final Comment parent;

  @JsonKey(
    fromJson: Authorperm.fromListAuthorpermString,
    toJson: Authorperm.toListAuthorpermString,
  )
  final List<Authorperm> replies;

  Thread copyWith({
    Authorperm? authorperm,
    Comment? parent,
    List<Authorperm>? replies,
  }) {
    return Thread(
      authorperm: authorperm ?? this.authorperm,
      parent: parent ?? this.parent,
      replies: replies ?? this.replies,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [authorperm, parent, replies];

  Map<String, dynamic> toJson() => _$ThreadToJson(this);
}
