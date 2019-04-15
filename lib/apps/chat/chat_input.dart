import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/message.dart';
import 'package:flutter_firebase_app/services/auth.dart';

class ChatInput extends StatefulWidget {
  final String chatId;

  const ChatInput({this.chatId});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.reference().child('messages');
  FirebaseUser currentUser;

  final TextEditingController _inputController = TextEditingController();
  bool _active = false;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  fetchCurrentUser() async {
    currentUser = await AuthService().getCurrentUser();
  }

  void _handleSubmit(text) async {
    final messageText = text.trim();
    if (messageText.isEmpty) {
      return;
    }

    _inputController.clear();
    setState(() {
      _active = false;
    });

    final Author author =
        Author(uid: currentUser.uid, name: currentUser.displayName);
    final Message message = Message(author, messageText);
    _messagesRef.push().set(message.toJson());

    final Author otherAuthor =
        Author(uid: 'otherUID', name: 'otherDisplayname');
    final Message messageResponse = Message(otherAuthor, messageText);
    _messagesRef.push().set(messageResponse.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 8.0, bottom: 8, top: 8),
      child: Row(
        children: <Widget>[
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                color: Color.fromARGB(11, 0, 0, 0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration.collapsed(hintText: "Aa"),
                  controller: _inputController,
                  onChanged: (String text) {
                    setState(() {
                      _active = text.trim().isNotEmpty;
                    });
                  },
                  onSubmitted: _handleSubmit,
                ),
              ),
            ),
          ),
          Container(
            child: IconButton(
              color: _active ? Color.fromARGB(255, 234, 98, 14) : Colors.grey,
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmit(_inputController.text),
            ),
          )
        ],
      ),
    );
  }
}
