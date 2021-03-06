import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manabar.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Manabar extends Equatable {
  const Manabar({required this.currentMana, required this.lastUpdateTime});

  factory Manabar.fromJson(Map<String, dynamic> json) =>
      _$ManabarFromJson(json);

  final int currentMana;
  final DateTime lastUpdateTime;

  Map<String, dynamic> toJson() => _$ManabarToJson(this);

  @override
  List<Object?> get props => [currentMana, lastUpdateTime];
}
