import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:us_stock/constants.dart';
import 'package:us_stock/models/news_list_model.dart';
import 'package:us_stock/models/news_model.dart';
import 'package:us_stock/models/stock_quote_detail_model.dart';

class DataRepository {
  DataRepository._internal();

  static final DataRepository _instance = new DataRepository._internal();

  factory DataRepository() {
    return _instance;
  }

  static DataRepository get instance => _instance;

  Future<StockQuoteDetailModel> getStockQuoteDetail(String symbol) async {
    final api = Constants.API_STOCK_QUOTE.replaceAll("{symbol}", symbol);
    debugPrint("getStockQuoteDetail api: $api");
    final response = await http.get(api);
    StockQuoteDetailModel model =
        StockQuoteDetailModel.fromJson(jsonDecode(response.body));
    return model;
  }

  Future<List<NewsModel>> getNewsList(String symbol) async {
    final api = Constants.API_NEWS_QUOTE.replaceAll("{symbol}", symbol);
    debugPrint("getNewsList api: $api");
    final response = await http.get(api);
    List responseJson = json.decode(response.body);
    List<NewsModel> newsModelList =  responseJson.map((m) => NewsModel.fromJson(m)).toList();
    return newsModelList;
  }
}
