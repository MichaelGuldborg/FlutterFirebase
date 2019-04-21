import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String date;
  final VoidCallback onPress;

  const RoundedCard({
    Key key,
    this.title = "",
    this.subTitle = "",
    this.date = "",
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 100,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(30.0),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(subTitle,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    )),
                Text(date,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
