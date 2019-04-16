import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback onPress;

  const DashboardButton({
    Key key,
    @required this.title,
    @required this.status,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onPress,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
          elevation: 4, //10,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("ICON"),
                    Text("NOTICE"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Text(status),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
