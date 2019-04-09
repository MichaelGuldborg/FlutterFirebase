import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/models/message.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardActivity extends StatefulWidget {
  @override
  DashboardActivityState createState() => DashboardActivityState();
}

class DashboardActivityState extends State<DashboardActivity> {
  final AuthService _authService = AuthService();
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  FirebaseUser currentUser;

  int _counter;
  DatabaseReference _counterRef;
  var _counterSubscription;

  DatabaseError _error;
  bool _anchorToBottom = false;

  DatabaseReference _messagesRef;
  var _messagesSubscription;

  @override
  void initState() {
    super.initState();

    /// init database connection
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    _counterRef.once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });

    _database.setPersistenceEnabled(true);
    _database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);
    _counterSubscription = _counterRef.onValue.listen((event) {
      setState(() {
        _error = null;
        _counter = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });

    _messagesRef = _database.reference().child('messages');
    _messagesSubscription =
        _messagesRef.limitToLast(10).onChildAdded.listen((Event event) {
      print('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch currentUser
    Future(() async {
      final user = await _authService.getCurrentUser();
      if (user == null) {
        // TODO better user feedback
        Navigator.of(context).pushReplacementNamed(Routes.auth);
        return;
      }

      // Update state
      setState(() {
        currentUser = user;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _counterSubscription.cancel();
    _messagesSubscription.cancel();
  }

  Future<void> _increment() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    final message = Message(Author(currentUser.uid, "name"), "hey");
    if (transactionResult.committed) {
      _messagesRef.push().set(message.toJson());
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
              child: Text("logout", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _authService.signOut();
                Navigator.of(context).pushReplacementNamed(Routes.auth);
              }),
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.user, color: Colors.white),
          )
        ],
        title: Text('Dashboard'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Checkbox(
                onChanged: (bool value) {
                  setState(() {
                    _anchorToBottom = value;
                  });
                },
                value: _anchorToBottom,
              ),
              title: const Text('Anchor to bottom'),
            ),
            Flexible(
              child: FirebaseAnimatedList(
                key: ValueKey<bool>(_anchorToBottom),
                query: _messagesRef,
                // reverse: _anchorToBottom,
                sort: _anchorToBottom
                    ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
                    : null,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: Text("$index: ${snapshot.value.toString()}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: bottomSheet,
      persistentFooterButtons: <Widget>[
        Text('Counter $_counter!'),
        Text('Welcome ${currentUser?.displayName}!')
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget bottomSheet = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: RaisedButton(
        color: Colors.black54,
        textColor: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Text(
          "create new",
          style: TextStyle(fontSize: 14, letterSpacing: 2),
        ),
        onPressed: () {},
      ));
}
