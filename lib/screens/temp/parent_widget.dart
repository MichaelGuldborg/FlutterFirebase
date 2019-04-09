import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/temp/inhreited_widget.dart';

class MyParentWidget {
  final counter = 1;

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      data: counter,
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
