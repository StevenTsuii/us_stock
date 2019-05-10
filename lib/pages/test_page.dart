import 'package:flutter/material.dart';
import 'package:us_stock/pages/stock_detail_page.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StockDetailPage()),
        );
      },
      child: Container(
          alignment: Alignment.center,
          color: Colors.greenAccent,
          margin: EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              "HAHA First time",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: Colors.orange,
                  background: Paint()..color = Colors.blueAccent),
            ),
          )),
    );
  }
}
