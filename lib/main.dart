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
  State<App> createState() => AppState();
}

// TODO change to _AppState.of(context) pattern
class AppState extends State<App> {
  final Auth _auth = Auth();
  FirebaseUser currentUser;

  void updateCurrentUser(FirebaseUser user) async {
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
      theme: ThemeData(),
      initialRoute: Routes.splash,
      routes: <String, WidgetBuilder>{
        Routes.splash: (BuildContext context) => SplashScreen(
              auth: _auth,
              updateCurrentUser: updateCurrentUser,
            ),
        Routes.auth: (BuildContext context) => AuthScreen(
              auth: _auth,
              updateCurrentUser: updateCurrentUser,
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
