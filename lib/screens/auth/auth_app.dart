import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/apps/auth/auth_screen.dart';
import 'package:flutter_firebase_app/apps/auth/login_screen.dart';
import 'package:flutter_firebase_app/apps/auth/pick_address_screen.dart';
import 'package:flutter_firebase_app/apps/auth/search_address_screen.dart';
import 'package:flutter_firebase_app/apps/auth/register_screen.dart';
import 'package:flutter_firebase_app/apps/auth/register_zip_screen.dart';
import 'package:flutter_firebase_app/apps/auth/reset_password_screen.dart';
import 'package:flutter_firebase_app/main.dart';

// Inherited widget
// https://medium.com/flutter-community/widget-state-buildcontext-inheritedwidget-898d671b7956

/*
auth_widget
  auth_view
  login_view
  register_view
 */

/*
abstract class AppStateHandler {
  void handleSignIn(FirebaseUser user);

  AppStateHandler of(BuildContext context) {
    return (context.ancestorWidgetOfExactType(AppStateHandler) as AppStateHandler);
  }
}

 */

class _AuthAppProvider extends InheritedWidget {
  final AuthAppState state;

  _AuthAppProvider({
    Key key,
    @required Widget child,
    @required this.state,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_AuthAppProvider oldWidget) {
    return true;
  }
}

class AuthApp extends StatefulWidget {
  @override
  AuthAppState createState() => AuthAppState();
}

class AuthAppRoutes {
  static const auth = "auth/";
  static const login = "login/";
  static const reset_password = "reset_password/";

  /// Register
  static const register = "register/";
  static const register_zip = "register_zip/";
  static const search_address = "search_address/";
  static const pick_address = "pick_address/";
}

class AuthAppState extends State<AuthApp> {
  static AuthAppState of(BuildContext context) {
    return (context.ancestorWidgetOfExactType(AuthAppState) as AuthAppState);
  }

  void handleSignIn(FirebaseUser user) async {
    if (user == null) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return _AuthAppProvider(
      state: this,
      child: MaterialApp(
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(), // TODO CHECK iOS
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        initialRoute: AuthAppRoutes.auth,
        routes: <String, WidgetBuilder>{
          AuthAppRoutes.auth: (BuildContext context) => AuthScreen(),
          AuthAppRoutes.login: (BuildContext context) => LoginScreen(),
          AuthAppRoutes.reset_password: (BuildContext context) => ResetPasswordScreen(),
          AuthAppRoutes.register: (BuildContext context) => RegisterScreen(),
          AuthAppRoutes.register_zip: (BuildContext context) => RegisterZipScreen(),
          AuthAppRoutes.search_address: (BuildContext context) => SearchAddressScreen(),
          AuthAppRoutes.pick_address: (BuildContext context) => PickAddressScreen(),
        },
      ),
    );
  }
}
