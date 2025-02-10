import "package:flutter_store/model/items.dart";
import "package:json_annotation/json_annotation.dart";

import "items.dart";
part 'data.g.dart';
@JsonSerializable()
class Data {
  Data();
  String? lastId;
  List<Items>? items;

  factory Data.fromJson(Map<String,dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}