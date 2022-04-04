import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'comments.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Comments {
  final Authorperm parent;

  final Map<String, Comment> items;

  /// A map of authorperms to the children of each piece of content
  final Map<String, List<String>> children;

  const Comments(
      {required this.parent, required this.items, required this.children});

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  int get length => items.length;
  Comment? operator [](String authorperm) => items[authorperm];

  List<Comment>? childrenOf(Authorperm postId) =>
      children[postId.toString()]?.map((ap) => items[ap]!).toList();

  // TODO remove the ?? const [] if it can't actually happen
  List<Comment> get rootReplies => childrenOf(parent) ?? const [];

  Comments copyWith(
      {Authorperm? parent,
      Map<String, Comment>? items,
      Map<String, List<String>>? children}) {
    return Comments(
        parent: parent ?? this.parent,
        items: items ?? this.items,
        children: children ?? this.children);
  }

  @override
  String toString() => 'Comments on $parent: $children';

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
}
