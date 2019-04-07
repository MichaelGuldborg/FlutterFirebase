import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  final bool transparent;

  RoundedButton(
      {@required this.text,
      @required this.onPressed,
      this.transparent = false});

  @override
  Widget build(BuildContext context) {
    final color = transparent ? Colors.transparent : Colors.white;
    final borderColor = transparent ? Colors.white70 : Colors.transparent;
    final textColor = transparent ? Colors.white : Colors.black;
    final splashColor = transparent ? Colors.white70 : Colors.black54;

    return Material(
        elevation: 0,
        color: color,
        shape: const StadiumBorder(),
        child: InkWell(
            borderRadius: BorderRadius.circular(100.0),
            splashColor: splashColor,
            onTap: onPressed,
            child: Container(
              width: 300.0,
              height: 56.0,
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1),
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
              ),
            )));
  }
}
