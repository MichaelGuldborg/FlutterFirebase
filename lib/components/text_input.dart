import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput();

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onSubmitted: (text) {},
      ),
    );
  }
}
