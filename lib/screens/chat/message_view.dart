import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  final String text;
  final bool isMe;

  MessageView({this.text, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          (!isMe
              ? Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 14,
                  ))
              : Container()),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 150,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                color: isMe
                    ? Theme.of(context).primaryColor
                    : Color.fromARGB(11, 0, 0, 0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 15, color: isMe ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
