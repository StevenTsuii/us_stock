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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Symbol",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Company Name",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Last update time: 9 Jun 2019",
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "1066.41",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 24),
                            ),
                            Text(
                              "(+15.21%)",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 18),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Highest: ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              "1080.99",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              "Lowest: ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              "1000.99",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                        Text(
                          "Open: 1011.22",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),

                        Text(
                          "Close: 1080.23",
                          style: TextStyle(color: Colors.black, fontSize: 16),
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
