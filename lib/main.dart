import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/screens/auth/auth_activity.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_activity.dart';
import 'package:flutter_firebase_app/screens/splash_activity.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashActivity(),
      routes: <String, WidgetBuilder>{
        Routes.splash: (BuildContext context) => SplashActivity(),
        Routes.auth: (BuildContext context) => AuthActivity(),
        Routes.home: (BuildContext context) => DashboardActivity(),
      },
    );
  }
}
