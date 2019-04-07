import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  AuthService _authService = AuthService();


  final String displayName = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {

            },
            icon: Icon(FontAwesomeIcons.user, color: Colors.white),
          )
        ],
        title: Text('Flutter Firebase Authentication'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome $displayName!')),
          Center(
            child: RaisedButton(
              onPressed: () async {
                await _authService.signOut();
                Navigator.of(context).pushReplacementNamed(Routes.splash);
              },
              child: Text('Sign Out'),
            ),
          ),
        ],
      ),
    );
  }
}
