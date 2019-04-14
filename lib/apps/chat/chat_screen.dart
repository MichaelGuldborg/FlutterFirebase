import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/models/message.dart';
import 'package:flutter_firebase_app/apps/chat/chat_input.dart';
import 'package:flutter_firebase_app/apps/chat/message_view.dart';

class ChatView extends StatefulWidget {
  final String chatId;

  const ChatView({this.chatId});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.reference().child('messages');

  List<Message> _messageList = List<Message>();
  StreamSubscription<Event> addSubscription;
  ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addSubscription = _messagesRef.onChildAdded.listen((event) {
      setState(() {
        _messageList.insert(0, Message.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  void dispose() {
    addSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseUser currentUser = AppState.of(context).currentUser;

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          iconTheme: IconThemeData(color: Color.fromARGB(255, 234, 98, 14)),
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
          elevation: 0,
          title: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 14,
                ),
              ),
              Text(
                "Chat",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          actions: [
            IconButton(
                color: Color.fromARGB(255, 234, 98, 14),
                onPressed: () {
                  print("_messageList.length: ");

                  // _scrollController
                  //.jumpTo(_scrollController.position.maxScrollExtent);
                },
                icon: Icon(Icons.more_vert))
          ],
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                reverse: true,
                controller: _scrollController,
                itemBuilder: (_, int index) => MessageView(
                    text: _messageList[index].text,
                    isMe: _messageList[index].author.uid ==
                        currentUser?.uid),
                itemCount: _messageList.length,
              ),
            ),
            Container(
              decoration: BoxDecoration(),
              child: ChatInput(
                chatId: 'chatId',
              ),
            )
          ],
        ));
  }
}
