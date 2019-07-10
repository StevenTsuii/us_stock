import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()

class NewsModel {
  double datetime;
  String headline;
  String source;
  String url;
  String summary;
  String related;
  String image;
  String lang;
  bool hasPaywall;

  NewsModel();

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);
}