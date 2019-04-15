import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/apps/auth/auth_app.dart';
import 'package:flutter_firebase_app/apps/event/event_screen.dart';
import 'package:flutter_firebase_app/apps/splash_screen.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  State<App> createState() => AppState();
}

class AppRoutes {
  static const splash = "splash";
  static const auth = "auth";
  static const dashboard = "dashboard";
  static const settings = "settings";
  static const chat = "chat";
  static const event = "event";
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: Colors.transparent),
      initialRoute: AppRoutes.splash,
      routes: <String, WidgetBuilder>{
        AppRoutes.splash: (BuildContext context) => SplashScreen(),
        AppRoutes.auth: (BuildContext context) => AuthApp(),
        AppRoutes.dashboard: (BuildContext context) => EventScreen(),

        /*
        Routes.settings: (BuildContext context) => SettingsScreen(),
        Routes.chat: (BuildContext context) => ChatView(chatId: 'chatIdtemp'),
        Routes.event: (BuildContext context) => EventEditScreen(),
         */
      },
    );
  }
}
