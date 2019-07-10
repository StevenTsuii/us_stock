import 'package:json_annotation/json_annotation.dart';

import 'news_model.dart';
part 'news_list_model.g.dart';

@JsonSerializable()
class NewsListModel {
  List<NewsModel> newsModelList;

  NewsListModel();

  factory NewsListModel.fromJson(Map<String, dynamic> json) {
    return _$NewsListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewsListModelToJson(this);
}

//@JsonSerializable()
//class ListResponseModel<T> extends BaseResponseModel {
//  @_Converter()
//  List<T> content;
//  String total;
//
//  ListResponseModel();
//  factory ListResponseModel.fromJson(Map<String, dynamic> json) {
//    return _$ListResponseModelFromJson<T>(json);
//  }
//  Map<String, dynamic> toJson() => _$ListResponseModelToJson(this);
//}
