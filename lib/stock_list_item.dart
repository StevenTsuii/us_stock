import 'package:flutter/material.dart';

class StockListItem extends StatelessWidget {
  final String stockName;

  const StockListItem(this.stockName);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.lightBlueAccent),
      child: Padding(
          padding: const EdgeInsets.all(8.0), child: Text("$stockName 500")),
    );
  }
}