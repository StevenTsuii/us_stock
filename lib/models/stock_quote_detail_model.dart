import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build
part 'stock_quote_detail_model.g.dart';

@JsonSerializable()
class StockQuoteDetailModel {
  String symbol;
  String companyName;
  String calculationPrice;
  double open;
  double openTime;
  double close;
  double closeTime;
  double high;
  double low;
  double latestPrice;
  String latestSource;
  String latestTime;
  double latestUpdate;
  double change;
  double changePercent;
  double week52High;
  double week52Low;
  double latestVolume;
  double previousClose;
  double marketCap;

  StockQuoteDetailModel();

  factory StockQuoteDetailModel.fromJson(Map<String, dynamic> json) => _$StockQuoteDetailModelFromJson(json);

}


//{
//"symbol": "GOOG",
//"companyName": "Alphabet, Inc.",
//"calculationPrice": "tops",
//"open": 1137.21,
//"openTime": 1557840600869,
//"close": 1132.03,
//"closeTime": 1557777600472,
//"high": 1140.42,
//"low": 1128,
//"latestPrice": 1129.33,
//"latestSource": "IEX real time price",
//"latestTime": "10:11:09 AM",
//"latestUpdate": 1557843069867,
//"latestVolume": 304621,
//"iexRealtimePrice": 1129.33,
//"iexRealtimeSize": 100,
//"iexLastUpdated": 1557843069867,
//"delayedPrice": 1129.39,
//"delayedPriceTime": 1557842181911,
//"extendedPrice": 1138.91,
//"extendedChange": 9.58,
//"extendedChangePercent": 0.00848,
//"extendedPriceTime": 1557840600816,
//"previousClose": 1132.03,
//"change": -2.7,
