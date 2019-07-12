import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:us_stock/models/news_model.dart';
import 'package:us_stock/models/stock_quote_detail_model.dart';
import 'package:us_stock/repository/data_repository.dart';

class StockDetailView extends StatefulWidget {
  final String query;

  StockDetailView({Key key, this.query}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StockDetailViewState();
  }
}

class _StockDetailViewState extends State<StockDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        Text(
                          snapshot.data.symbol,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          snapshot.data.companyName,
                          style: TextStyle(color: Colors.black, fontSize: 20),
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
                              "${snapshot.data.change >= 0 ? "+" : ""}${snapshot.data.change.toStringAsFixed(3)}",
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
                              "(${snapshot.data.changePercent.toStringAsFixed(2)}%)",
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
                              child: _getKeyText("High"),
                            ),
                            Expanded(
                              flex: 1,
                              child: _getValueColoredText(
                                  snapshot.data, snapshot.data.high),
                            ),
                            Expanded(flex: 1, child: _getKeyText("Open")),
                            Expanded(
                              flex: 1,
                              child: _getValueColoredText(
                                  snapshot.data, snapshot.data.open),
                            ),
                          ],
                        ),

                        // ****** Second Row ******
                        Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: _getKeyText("Low")),
                            Expanded(
                                flex: 1,
                                child: _getValueColoredText(
                                    snapshot.data, snapshot.data.low)),
                            Expanded(
                                flex: 1, child: _getKeyText("Prev. close")),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  "${snapshot.data.previousClose.toStringAsFixed(3)}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                )),
                          ],
                        ),

                        // ****** Third Row ******
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: _getKeyText("52WK High"),
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
                            Expanded(
                              flex: 1,
                              child: _getKeyText("Volume"),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${snapshot.data.latestVolume != null ? "${FlutterMoneyFormatter(amount: snapshot.data.latestVolume).output.compactNonSymbol}" : "---"}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),

                        // ****** Forth Row ******
                        Row(
                          children: <Widget>[
                            Expanded(flex: 1, child: _getKeyText("52WK Low")),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${snapshot.data.week52Low != null ? snapshot.data.week52Low.toStringAsFixed(3) : "---"}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: _getKeyText("Market Cap"),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${snapshot.data.marketCap != null ? "${FlutterMoneyFormatter(amount: snapshot.data.marketCap).output.compactNonSymbol}" : "---"}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: FutureBuilder<List<NewsModel>>(
                              future:
                                  DataRepository().getNewsList(widget.query),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<NewsModel>> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Text("ConnectionState.none");
                                  case ConnectionState.active:
                                    return Text("ConnectionState.active");
                                  case ConnectionState.waiting:
                                    return Center(
                                        child: CircularProgressIndicator());
                                  case ConnectionState.done:
                                    if (snapshot.hasError) {
                                      return Text(
                                          "Cannot found this symbol '${widget.query}");
                                    } else {
                                      return ListView.separated(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Text(
                                              "${snapshot.data[index].headline}",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Text(
                                              "${snapshot.data[index].summary}",
                                              maxLines: 4,
                                              overflow: TextOverflow.fade,
                                            ),
//                                              leading: CachedNetworkImage(
//                                                imageUrl:
//                                                    "${snapshot.data[index].url}?token=${Constants.token}",
//                                                placeholder:
//                                                    new CircularProgressIndicator(),
//                                                errorWidget: Icon(Icons.error),
//                                              ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              color: Colors.black,
                                            ),
                                        itemCount: snapshot.data.length,
                                      );
                                    }
                                }
                              }),
                        )
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }

  Text _getValueColoredText(StockQuoteDetailModel model, double value) {
    return Text(
      "${value != null ? value.toStringAsFixed(3) : "---"}",
      style: _getValueTextStyle(value, model.previousClose),
    );
  }

  Text _getValueText(double value) {
    return Text(
      "${value != null ? value.toStringAsFixed(3) : "---"}",
      style: TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  Text _getKeyText(String keyName) {
    return Text(
      "$keyName: ",
      style: TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  TextStyle _getValueTextStyle(double value, double previousClose) {
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
