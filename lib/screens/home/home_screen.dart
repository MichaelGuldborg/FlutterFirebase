import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_app/bloc/authentication/authentication.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser firebaseUser;

  HomeScreen({Key key, @required this.firebaseUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.profile, arguments: firebaseUser);
            },
            icon: Icon(FontAwesomeIcons.user, color: Colors.white),
          )
        ],
        title: Text('Flutter Firebase Authentication'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome ${firebaseUser.displayName}!')),
          Center(
            child: RaisedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).dispatch(Logout());
              },
              child: Text('Sign Out'),
            ),
          ),
        ],
      ),
    );
  }
}
