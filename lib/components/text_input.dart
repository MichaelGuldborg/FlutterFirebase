import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final controller;
  final Future<void> Function(String text) onChanged;

  const TextInput({Key key,
    this.hintText,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.controller,
    this.onChanged,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: TextField(
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
