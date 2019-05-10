import 'package:flutter/material.dart';

class PressCountButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PressCountButtonState();


}

class _PressCountButtonState extends State<PressCountButton> {

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: _addCounter,
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.lightBlueAccent,),
          child:
          Padding(padding: EdgeInsets.all(30.0), child: Text("You pressed $_counter time"),)
          ));
  }

  void _addCounter() {
    setState(() {
      _counter++;
    });
  }
}