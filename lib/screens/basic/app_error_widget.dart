import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final int code;
  final String message;

  const AppErrorWidget({
    Key key,
    this.code,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("An error has occoured"),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
