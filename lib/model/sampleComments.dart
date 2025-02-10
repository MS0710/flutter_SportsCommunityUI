import "package:flutter_store/model/author.dart";
import "package:json_annotation/json_annotation.dart";

part 'sampleComments.g.dart';
@JsonSerializable()
class SampleComments {
  SampleComments();
  String? created;
  Author? author;
  String? _id;
  String? content;

  factory SampleComments.fromJson(Map<String,dynamic> json) => _$SampleCommentsFromJson(json);
  Map<String, dynamic> toJson() => _$SampleCommentsToJson(this);
}