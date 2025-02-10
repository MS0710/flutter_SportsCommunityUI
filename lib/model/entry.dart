import "package:flutter_store/model/sampleComments.dart";
import "package:json_annotation/json_annotation.dart";

import "author.dart";
part 'entry.g.dart';
@JsonSerializable()
class Entry {
  Entry();
  String? country;
  String? reason;
  List? achievements;
  num? internalShareCount;
  num? stateValue;
  num? feel;
  String? type;
  String? contentTypeStr;
  num? relation;
  List? hashTags;
  String? province;
  String? citycode;
  String? id;
  String? state;
  List? contentType;
  num? likes;
  List? images;
  Author? author;
  String? created;
  Map<String,dynamic>? expansion;
  num? quality;
  Map<String,dynamic>? meta;
  num? commentUsers;
  bool? vlog;
  String? schema;
  String? city;
  String? timezone;
  String? content;
  List? geo;
  bool? public;
  bool? noise;
  List<SampleComments>? sampleComments;
  List? likeRank;
  num? viewCount;
  String? place;
  bool? isAd;
  String? nationCode;
  num? comments;
  String? photo;
  num? squadDayIndex;
  Map<String,dynamic>? likeStatistics;
  String? clientIp;
  num? manualViewCount;
  num? externalShareCount;
  num? favoriteCount;

  factory Entry.fromJson(Map<String,dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);
}