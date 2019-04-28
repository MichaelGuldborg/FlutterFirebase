import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';
import 'package:flutter_firebase_app/screens/auth/login_screen.dart';
import 'package:flutter_firebase_app/screens/auth/register_screen.dart';
import 'package:flutter_firebase_app/screens/auth/reset_password_screen.dart';

// Inherited widget
// https://medium.com/flutter-community/widget-state-buildcontext-inheritedwidget-898d671b7956

class AuthWidgetRoutes {
  static const auth = "auth/";
  static const login = "login/";
  static const register = "register/";
  static const reset_password = "reset_password/";
}

class AuthWidget extends StatefulWidget {
  @override
  AuthWidgetState createState() => AuthWidgetState();
}

class AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      initialRoute: AuthWidgetRoutes.auth,
      routes: <String, WidgetBuilder>{
        AuthWidgetRoutes.auth: (BuildContext context) => AuthScreen(),
        AuthWidgetRoutes.login: (BuildContext context) => LoginScreen(),
        AuthWidgetRoutes.reset_password: (BuildContext context) => ResetPasswordScreen(),
        AuthWidgetRoutes.register: (BuildContext context) => RegisterScreen(),
      },
    );
  }
}
