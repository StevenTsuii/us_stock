import 'package:json_annotation/json_annotation.dart';

part 'stock_model.g.dart';

@JsonSerializable()

class StockModel {
  String name;
  String price;
}
