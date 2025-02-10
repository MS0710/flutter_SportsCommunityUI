import "package:json_annotation/json_annotation.dart";

part 'image.g.dart';
@JsonSerializable()
class Image1 {
  Image1();
  int? id;
  String? imageName;

  factory Image1.fromJson(Map<String,dynamic> json) => _$Image1FromJson(json);
  Map<String, dynamic> toJson() => _$Image1ToJson(this);
}