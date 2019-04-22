import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';
import 'package:flutter_firebase_app/screens/auth/login_screen.dart';
import 'package:flutter_firebase_app/screens/auth/register_screen.dart';
import 'package:flutter_firebase_app/screens/auth/reset_password_screen.dart';
import 'package:flutter_firebase_app/screens/auth/search_address_screen.dart';
import 'package:flutter_firebase_app/screens/auth/search_zip_screen.dart';
import 'package:flutter_firebase_app/screens/auth/select_address_screen.dart';

// Inherited widget
// https://medium.com/flutter-community/widget-state-buildcontext-inheritedwidget-898d671b7956

class AuthWidget extends StatefulWidget {
  @override
  AuthWidgetState createState() => AuthWidgetState();
}

class AuthWidgetRoutes {
  static const auth = "auth/";
  static const login = "login/";
  static const register = "register/";
  static const reset_password = "reset_password/";

  /// Register
  static const register_zip = "register_zip/";
  static const search_address = "search_address/";
  static const pick_address = "pick_address/";
}

class AuthWidgetState extends State<AuthWidget> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(), // TODO CHECK iOS
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      initialRoute: AuthWidgetRoutes.auth,
      routes: <String, WidgetBuilder>{
        AuthWidgetRoutes.auth: (BuildContext context) => AuthScreen(),
        AuthWidgetRoutes.login: (BuildContext context) => LoginScreen(),
        AuthWidgetRoutes.reset_password: (BuildContext context) => ResetPasswordScreen(),
        AuthWidgetRoutes.register: (BuildContext context) => RegisterScreen(),
        AuthWidgetRoutes.register_zip: (BuildContext context) => RegisterZipScreen(),
        AuthWidgetRoutes.search_address: (BuildContext context) => SearchAddressScreen(),
        AuthWidgetRoutes.pick_address: (BuildContext context) => PickAddressScreen(),
      },
    );
  }
}
