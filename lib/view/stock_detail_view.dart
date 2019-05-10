import 'package:flutter/material.dart';

class StockDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StockDetailViewState();
  }
}

class _StockDetailViewState extends State<StockDetailView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.black54,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text("GOOG"),
                  Text("Alphabet, Incasdfdsfasdf"),
                  Text("GOOG"),
                  Text("Alphabet, Inc")
                ],
              ),
            ),
            _buildStockQuoteItem("Open: ", "245"),
            _buildStockQuoteItem("Highest: ", "200"),
            _buildStockQuoteItem("52week high: 100", "52week low: 43"),
            _buildStockQuoteItem("Open: 298", "Close: 245"),
            _buildStockQuoteItem("Highest: 300", "Lowest: 200"),
            _buildStockQuoteItem("52week high: 100", "52week low: 43"),
          ],
        ),
      ),
    );
  }

  Widget _addPadding(Widget widget) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: widget,
      ),
      color: Colors.black,
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: 20.0,
//        background: Paint()..color = Colors.red,
        color: Colors.white);
  }

  Widget _buildStockQuoteItem(String value, String value2) {
    return _addPadding(Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Text(
            value,
            style: _getTextStyle(),
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            value2,
            style: _getTextStyle(),
            textDirection: TextDirection.rtl,
          ),
          flex: 1,
        )
      ],
    ));
  }
}
