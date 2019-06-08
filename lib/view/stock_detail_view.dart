import 'package:flutter/material.dart';
import 'package:us_stock/models/stock_quote_detail_model.dart';
import 'package:us_stock/repository/data_repository.dart';

class StockDetailView extends StatefulWidget {
  final String query;

  StockDetailView(this.query);

  @override
  State<StatefulWidget> createState() {
    return _StockDetailViewState(query);
  }
}

class _StockDetailViewState extends State<StockDetailView> {
  StockQuoteDetailModel _stockQuoteDetailModel;

  _StockDetailViewState(String query);

  @override
  void initState() {
    super.initState();
    _requestStockQuoteDetail(widget.query);
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
        color: Colors.white,
        child: Center(
          child: FutureBuilder<StockQuoteDetailModel>(
            future: DataRepository().getStockQuoteDetail(widget.query),
            builder: (BuildContext context,
                AsyncSnapshot<StockQuoteDetailModel> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("ConnectionState.none");
                case ConnectionState.active:
                  return Text("ConnectionState.active");
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text("Cannot found this symbol '${widget.query}'");
                  } else {
//                      return Text(
//                          "ConnectionState.done Result:${snapshot.data.symbol} ==> ${snapshot.data.companyName}");
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Text AAAAAAAAA"),
                            Text("Text BBBBBBBB")
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                  "Symbol: ${_stockQuoteDetailModel?.symbol?.toUpperCase()}"),
                              Text(
                                  "Company Name: ${_stockQuoteDetailModel?.companyName}"),
                            ],
                          ),
                        ),
                        _buildStockQuoteItem(
                            "Latest Price: ${_stockQuoteDetailModel?.latestPrice}",
                            ""),
                        _buildStockQuoteItem(
                            "Highest: ${_stockQuoteDetailModel?.high}",
                            "Lowest: ${_stockQuoteDetailModel?.low}"),
                        _buildStockQuoteItem(
                            "Open: ${_stockQuoteDetailModel?.open}",
                            "Close: ${_stockQuoteDetailModel?.close}"),
//                        ListView.builder(
//                            itemCount: 10,
//                            itemBuilder: (BuildContext context, int index) {
//                              return Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                children: <Widget>[
//                                  Text("Text AAAAAAAAA"),
//                                  Text("Text BBBBBBBB")
//                                ],
//                              );
//                            }),
                      ],
                    );
                  }
              }
            },
          ),
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
