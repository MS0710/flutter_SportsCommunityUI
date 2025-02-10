import "package:json_annotation/json_annotation.dart";

import "entry.dart";
part 'items.g.dart';
@JsonSerializable()
class Items {
  Items();
  //String? lastId;
  //List<Entry>? entry;
  Entry? entry;

  factory Items.fromJson(Map<String,dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}