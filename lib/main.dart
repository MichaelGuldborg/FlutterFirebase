import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/auth/auth_widget.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_widget.dart';
import 'package:flutter_firebase_app/screens/event/event_screen.dart';
import 'package:flutter_firebase_app/screens/settings/settings_screen.dart';
import 'package:flutter_firebase_app/screens/splash_screen.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  State<App> createState() => AppState();
}

class AppRoutes {
  static const splash = "splash";
  static const auth = "auth";
  static const dashboard = "dashboard";
  static const event_dashboard = "event_dashboard";

  static const settings = "settings";
  static const chat = "chat";
  static const event = "event";
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.transparent,
        textTheme: TextTheme(
            title: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
      ),
      initialRoute: AppRoutes.splash,
      routes: <String, WidgetBuilder>{
        AppRoutes.splash: (BuildContext context) => SplashScreen(),
        AppRoutes.auth: (BuildContext context) => AuthWidget(),
        AppRoutes.settings: (BuildContext context) => SettingsScreen(),
        AppRoutes.dashboard: (BuildContext context) => DashboardWidget(),
        AppRoutes.event_dashboard: (BuildContext context) => EventScreen(),

        /*
        Routes.settings: (BuildContext context) => SettingsScreen(),
        Routes.chat: (BuildContext context) => ChatView(chatId: 'chatIdtemp'),
        Routes.event: (BuildContext context) => EventEditScreen(),
         */
      },
    );
  }
}
