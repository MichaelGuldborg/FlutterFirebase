import 'package:flutter/material.dart';

class FlatListButton extends StatelessWidget {
  final String label;
  final String text;
  final bool topBorder;
  final VoidCallback onPress;

  const FlatListButton({
    Key key,
    @required this.label,
    @required this.text,
    this.onPress,
    this.topBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: topBorder ? 1 : 0, color: Colors.grey.withAlpha(70)),
          bottom: BorderSide(width: 1, color: Colors.grey.withAlpha(70)),
        ),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
          Row(
            children: <Widget>[
              Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
              SizedBox(width: 16),
              Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
