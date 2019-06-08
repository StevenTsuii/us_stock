import 'package:flutter/material.dart';
import 'package:us_stock/view/stock_detail_view.dart';

class StockDetailPage extends StatefulWidget {
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
          builder: (context) => ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return StockDetailView("goog");
                },
                itemCount: 1,
                padding: EdgeInsets.all(8.0),
              )),
    );
  }
}
