import "package:json_annotation/json_annotation.dart";

import "image.dart";

part 'product.g.dart';
@JsonSerializable()
class Product {
  Product();
  int? id;
  String? name;
  List<Image1>? images;

  factory Product.fromJson(Map<String,dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}