import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventScreen extends StatefulWidget {
  @override
  EventScreenState createState() => EventScreenState();
}

class EventScreenState extends State<EventScreen> {
  final DatabaseReference _eventRef =
      FirebaseDatabase.instance.reference().child('events');
  DatabaseError _error;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final FirebaseUser currentUser = AppState.of(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
              child: Text("chat", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                Navigator.of(context).pushNamed(Routes.chat);
              }),
          FlatButton(
              child: Text("logout", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await Auth().signOut();
                Navigator.of(context).pushReplacementNamed(Routes.auth);
              }),
          IconButton(
            icon: Icon(FontAwesomeIcons.user, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.settings);
            },
          )
        ],
        title: Text('Dashboard'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: FirebaseAnimatedList(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                query: _eventRef,
                controller: _scrollController,
                sort: (DataSnapshot a, DataSnapshot b) =>
                    b.key.compareTo(b.key),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return _eventView(snapshot);
                },
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[Text('Welcome ${currentUser?.email}!')],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.event);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _eventView(DataSnapshot snapshot) => Container(
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(children: [
          Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(right: 8.0),
              color: Colors.grey),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _eventViewText("${snapshot.value['title']}"),
                  _eventViewText("${snapshot.value['description']}"),
                  _eventViewText("${snapshot.value['time']}"),
                ]),
          ),
        ]),
      );

  Widget _eventViewText(String text) => Expanded(
      child: Container(alignment: Alignment.centerLeft, child: Text(text)));
}
