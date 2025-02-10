// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data()
  ..lastId = json['lastId'] as String?
  ..items = (json['items'] as List<dynamic>?)
      ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'lastId': instance.lastId,
      'items': instance.items,
    };
