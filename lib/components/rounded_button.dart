import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  final bool transparent;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final Color splashColor;

  RoundedButton(
      {@required this.text,
      @required this.onPressed,
      this.transparent = false,
      this.color = Colors.black,
      this.borderColor = Colors.black54,
      this.textColor = Colors.white,
      this.splashColor = Colors.white70});

  static white({
    @required text,
    @required onPressed,
    transparent = false,
  }) {
    return RoundedButton(
      text: text,
      onPressed: onPressed,
      transparent: transparent,
      color: Colors.white,
      borderColor: Colors.white70,
      textColor: Colors.black,
      splashColor: Colors.black54,
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = transparent ? Colors.transparent : this.color;
    final borderColor = transparent ? this.borderColor : Colors.transparent;
    final textColor = transparent ? this.color : this.textColor;
    final splashColor = transparent ? this.borderColor : this.textColor;

    return Material(
        elevation: 0,
        color: color,
        shape: const StadiumBorder(),
        child: InkWell(
            borderRadius: BorderRadius.circular(100.0),
            splashColor: splashColor,
            onTap: onPressed,
            child: Container(
              width: 300,
              height: 56,
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
