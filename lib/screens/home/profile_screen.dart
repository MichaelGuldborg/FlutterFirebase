import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_app/bloc/authentication/authentication.dart';

class ProfileScreen extends StatelessWidget {
  /*
  final FirebaseUser _firebaseUser;

  ProfileScreen({@required FirebaseUser firebaseUser})
      : assert(firebaseUser != null),
        _firebaseUser = firebaseUser;
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileScreen'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.network("https://picsum.photos/250?image=10"),
            Center(
              child: Text("ProfileScreen", style: TextStyle(fontSize: 35.0)),
            ),
          ],
        ),
      ),
    );
  }
}
