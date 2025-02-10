// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) => Items()
  ..entry = json['entry'] == null
      ? null
      : Entry.fromJson(json['entry'] as Map<String, dynamic>);

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'entry': instance.entry,
    };
