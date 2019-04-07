import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';
import 'package:flutter_firebase_app/screens/auth/login_screen.dart';
import 'package:flutter_firebase_app/screens/auth/register_screen.dart';
import 'package:flutter_firebase_app/screens/auth/splash_screen.dart';
import 'package:flutter_firebase_app/screens/home/about.dart';
import 'package:flutter_firebase_app/screens/home/contact.dart';
import 'package:flutter_firebase_app/screens/home/home_screen.dart';
import 'package:flutter_firebase_app/screens/home/profile_screen.dart';
import 'package:flutter_firebase_app/screens/home/settings_screen.dart';
import 'package:flutter_firebase_app/services/user_repository.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        // Authentication
        Routes.splash: (BuildContext context) => SplashScreen(),
        Routes.auth: (BuildContext context) => AuthScreen(),
        Routes.login: (BuildContext context) => LoginScreen(),
        Routes.register: (BuildContext context) => RegisterScreen(),

        // Dashboard
        Routes.home: (BuildContext context) => HomeScreen(),
        Routes.settings: (BuildContext context) => SettingsScreen(),
        Routes.profile: (BuildContext context) => ProfileScreen(),
        Routes.about: (BuildContext context) => AboutPage(),
        '/contact': (BuildContext context) => ContactPage(),
      },
    );
  }
}
