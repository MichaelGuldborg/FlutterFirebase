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
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: Offset(0, 5),
              blurRadius: 20,
            )
          ],
        ),
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
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
    );
  }
}
