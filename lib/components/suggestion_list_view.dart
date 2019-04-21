import 'package:flutter/material.dart';

Widget SuggetionListView(TextEditingController textController, List<String> suggestions) {
  return suggestions == null
      ? Container()
      : Expanded(
          child: ListView(
              children: suggestions
                  .map((String text) => ListTile(
                      title: Text(text),
                      dense: true,
                      onTap: () {
                        textController.value = textController.value.copyWith(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                          composing: TextRange.empty,
                        );
                      }))
                  .toList()));
}
