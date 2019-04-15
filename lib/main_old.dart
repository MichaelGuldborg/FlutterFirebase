import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/apps/auth/auth_app.dart';
import 'package:flutter_firebase_app/apps/chat/chat_screen.dart';
import 'package:flutter_firebase_app/apps/event/event_edit_screen.dart';
import 'package:flutter_firebase_app/apps/event/event_screen.dart';
import 'package:flutter_firebase_app/apps/settings/settings_screen.dart';
import 'package:flutter_firebase_app/apps/splash_screen.dart';

/*

void main() => runApp(App());

// Maybe switch to block ... don't know
class _AppStateProvider extends InheritedWidget {
  _AppStateProvider({
    Key key,
    @required Widget child,
    @required this.state,
  }) : super(key: key, child: child);

  final AppState state;

  @override
  bool updateShouldNotify(_AppStateProvider oldWidget) {
    return true;
  }
}

class App extends StatefulWidget {
  State<App> createState() => AppState();
}

// TODO change to _AppState.of(context) pattern
class AppState extends State<App> {
  static AppState of([BuildContext context]) {
    final provider = context.ancestorWidgetOfExactType(_AppStateProvider) as _AppStateProvider;
    return provider.state;
  }

  FirebaseUser _currentUser;

  FirebaseUser get currentUser => _currentUser;

  void updateCurrentUser(FirebaseUser user) async {
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AppStateProvider(
      state: this,
      child: MaterialApp(
        theme: ThemeData(backgroundColor: Colors.transparent),
        initialRoute: Routes.splash,
        routes: <String, WidgetBuilder>{
          Routes.splash: (BuildContext context) => SplashScreen(),
          Routes.auth: (BuildContext context) => AuthApp(),
          Routes.home: (BuildContext context) => EventScreen(),
          Routes.settings: (BuildContext context) => SettingsScreen(),
          Routes.chat: (BuildContext context) => ChatView(chatId: 'chatIdtemp'),
          Routes.event: (BuildContext context) => EventEditScreen(),
        },
      ),
    );
  }
}

 */
