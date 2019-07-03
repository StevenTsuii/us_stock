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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  snapshot.data.symbol,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  snapshot.data.companyName,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Last update time: ${snapshot.data.latestTime} - ${snapshot.data.latestSource}",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          Text(
                            "${snapshot.data.latestPrice.toStringAsFixed(3)}",
                            style: TextStyle(
                                color: snapshot.data.latestPrice >
                                        snapshot.data.previousClose
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 24),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "${snapshot.data.change >= 0 ? "+" : "-"}${snapshot.data.change.toStringAsFixed(3)}",
                                style: TextStyle(
                                    color: snapshot.data.change > 0
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "(${snapshot.data.changePercent >= 0 ? "+" : "-"}${snapshot.data.changePercent.toStringAsFixed(2)}%)",
                                style: TextStyle(
                                    color: snapshot.data.changePercent > 0
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 18),
                              ),
                            ],
                          ),

                          // ****** First Row ******
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Highest: ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${snapshot.data.high != null ? snapshot.data.high.toStringAsFixed(3) : "---"}",
                                  style: _getPriceTextStyle(snapshot.data.high,
                                      snapshot.data.previousClose),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "52wk high: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${snapshot.data.week52High.toStringAsFixed(3)}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // ****** Second Row ******
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Lowest: ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${snapshot.data.low != null ? snapshot.data.low.toStringAsFixed(3) : "---"}",
                                  style: _getPriceTextStyle(snapshot.data.low,
                                      snapshot.data.previousClose),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "52wk low: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${snapshot.data.week52Low.toStringAsFixed(3)}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // ****** Third Row ******
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Open: ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child:  Text(
                                  "${snapshot.data.open.toStringAsFixed(3)}",
                                  style: TextStyle(
                                      color: snapshot.data.open <
                                          snapshot.data.previousClose
                                          ? Colors.red
                                          : Colors.green,
                                      fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Volume: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${snapshot.data.latestVolume}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),


                          // ****** Forth Row ******
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Prev. close: ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child:    Text(
                                  "${snapshot.data.previousClose.toStringAsFixed(3)}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                )
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(""),

                              ),
                              Expanded(
                                flex: 1,
                                child: Text(""),
                               
                              ),
                            ],
                          ),


                          
                        ],
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  TextStyle _getPriceTextStyle(double value, double previousClose) {
    return TextStyle(
      color: value == null || value == previousClose
          ? Colors.grey
          : value < previousClose ? Colors.red : Colors.green,
      fontSize: 16,
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
