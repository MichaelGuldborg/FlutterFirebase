import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/temp/inhreited_widget.dart';

class MyChildWidget {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidget inheritedWidget = MyInheritedWidget.of(context);

    ///
    /// From this moment, the widget can use the data, exposed by the MyInheritedWidget
    /// by calling:  inheritedWidget.data
    ///
    return new Container(
      color: inheritedWidget.data.color,
    );
  }
}
