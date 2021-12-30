import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'comments.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Comments extends Equatable {
  final String parentAuthor;
  final String parentPermlink;

  final Map<String, Content> items;

  const Comments(
      {required this.parentAuthor,
      required this.parentPermlink,
      required this.items});

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  int get length => items.length;
  Content? operator [](String authorperm) => items[authorperm];

  factory Comments.fromJson(Map<String, dynamic> json) {
    try {
      return _$CommentsFromJson(json);
    } catch (e, s) {
      print('Failed parsing content $e');
      print(s);
      throw e;
    }
  }

  Map<String, dynamic> toJson() => _$CommentsToJson(this);

  @override
  List<Object?> get props => [parentAuthor, parentPermlink, items];
}