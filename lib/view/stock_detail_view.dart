import 'package:flutter/material.dart';
import 'package:us_stock/models/stock_quote_detail_model.dart';
import 'package:us_stock/repository/data_repository.dart';

class StockDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StockDetailViewState();
  }
}

class _StockDetailViewState extends State<StockDetailView> {
  final textEditingController = TextEditingController();

  StockQuoteDetailModel _stockQuoteDetailModel;


  @override
  void initState() {
    _requestStockQuoteDetail("aapl");
  }

  _requestStockQuoteDetail(String symbol) {
    DataRepository().getStockQuoteDetail(symbol).then((model) {
      setState(() {
        _stockQuoteDetailModel = model;
      });
    });
  }

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
            TextField(
              controller: textEditingController,
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _requestStockQuoteDetail(textEditingController.text);
                });
              },
              child: Text("Search"),
            ),
//            FutureBuilder<StockQuoteDetailModel>(
//              future: DataRepository().getStockQuoteDetail(_symbol),
//              builder: (BuildContext context,
//                  AsyncSnapshot<StockQuoteDetailModel> snapshot) {
//                switch (snapshot.connectionState) {
//                  case ConnectionState.none:
//                    return Text("ConnectionState.none");
//                  case ConnectionState.active:
//                    return Text("ConnectionState.active");
//                  case ConnectionState.waiting:
//                    return Text("ConnectionState.waiting");
//                  case ConnectionState.done:
//                    if (snapshot.hasError) {
//                      return Text(
//                          "ConnectionState.done with error ${snapshot.error.toString()}");
//                    } else {
//                      _updateStockQuoteDetailModel(snapshot.data);
//
//                      return Text(
//                          "ConnectionState.done Result:${snapshot.data.symbol} ==> ${snapshot.data.companyName}");
//                    }
//                    return null;
//                }
//              },
//            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                      "Symbol: ${_stockQuoteDetailModel?.symbol?.toUpperCase()}"),
                  Text("Company Name: ${_stockQuoteDetailModel?.companyName}"),
                ],
              ),
            ),
            _buildStockQuoteItem(
                "Latest Price: ${_stockQuoteDetailModel?.latestPrice}", ""),
            _buildStockQuoteItem("Highest: ${_stockQuoteDetailModel?.high}",
                "Lowest: ${_stockQuoteDetailModel?.low}"),
            _buildStockQuoteItem("Open: ${_stockQuoteDetailModel?.open}",
                "Close: ${_stockQuoteDetailModel?.close}"),
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
