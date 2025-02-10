// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..images = (json['images'] as List<dynamic>?)
      ?.map((e) => Image1.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
    };
