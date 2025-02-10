// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sampleComments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SampleComments _$SampleCommentsFromJson(Map<String, dynamic> json) =>
    SampleComments()
      ..created = json['created'] as String?
      ..author = json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>)
      ..content = json['content'] as String?;

Map<String, dynamic> _$SampleCommentsToJson(SampleComments instance) =>
    <String, dynamic>{
      'created': instance.created,
      'author': instance.author,
      'content': instance.content,
    };
