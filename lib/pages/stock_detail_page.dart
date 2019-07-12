import 'package:flutter/material.dart';
import 'package:us_stock/view/stock_detail_view.dart';

class StockDetailPage extends StatefulWidget {

  final String query;
  StockDetailPage({Key key, this.query}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StockDetailPageState();
  }
}

class _StockDetailPageState extends State<StockDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Detail"),
      ),
      body: Builder(
          builder: (context) => StockDetailView(query: widget.query,)),
    );
  }
}
