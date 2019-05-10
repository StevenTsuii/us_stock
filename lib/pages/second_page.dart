import 'package:flutter/material.dart';
import 'package:us_stock/press_count_button.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return PressCountButton();
      },
      itemCount: 20,
      padding: EdgeInsets.all(8.0),
    );
  }
}
