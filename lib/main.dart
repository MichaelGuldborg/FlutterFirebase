import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';
import 'package:flutter_firebase_app/screens/chat/chat_screen.dart';
import 'package:flutter_firebase_app/screens/event/event_edit_screen.dart';
import 'package:flutter_firebase_app/screens/event/event_screen.dart';
import 'package:flutter_firebase_app/screens/splash_screen.dart';
import 'package:flutter_firebase_app/services/auth.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

// TODO change to _AppState.of(context) pattern
class _AppState extends State<App> {
  final Auth _auth = Auth();
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
  }

  void _signIn(FirebaseUser user) async {
    if (user == null) {
      return;
    }

    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
        auth: _auth,
        signIn: _signIn,
      ),
      routes: <String, WidgetBuilder>{
        Routes.splash: (BuildContext context) => SplashScreen(
              auth: _auth,
            ),
        Routes.auth: (BuildContext context) => AuthScreen(
              auth: _auth,
              signIn: _signIn,
            ),
        Routes.home: (BuildContext context) => EventScreen(
              auth: _auth,
              currentUser: currentUser,
            ),
        Routes.chat: (BuildContext context) => ChatView(
              currentUser: currentUser,
              chatId: 'chatIdtemp',
            ),
        Routes.event: (BuildContext context) => EventEditScreen(
              currentUser: currentUser,
            ),
      },
    );
  }
}
