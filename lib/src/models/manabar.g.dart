// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manabar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manabar _$ManabarFromJson(Map<String, dynamic> json) => Manabar(
      currentMana: json['current_mana'] as int,
      lastUpdateTime: DateTime.parse(json['last_update_time'] as String),
    );

Map<String, dynamic> _$ManabarToJson(Manabar instance) => <String, dynamic>{
      'current_mana': instance.currentMana,
      'last_update_time': instance.lastUpdateTime.toIso8601String(),
    };
