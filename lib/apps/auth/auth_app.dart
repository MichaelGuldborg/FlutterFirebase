import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/apps/auth/auth_screen.dart';
import 'package:flutter_firebase_app/apps/auth/login_screen.dart';
import 'package:flutter_firebase_app/apps/auth/register_screen.dart';
import 'package:flutter_firebase_app/apps/auth/reset_password_screen.dart';
import 'package:flutter_firebase_app/apps/splash_screen.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/services/auth.dart';

// Inherited widget
// https://medium.com/flutter-community/widget-state-buildcontext-inheritedwidget-898d671b7956

/*
auth_widget
  auth_view
  login_view
  register_view
 */

class _StateProvider extends InheritedWidget {
  _StateProvider({
    Key key,
    @required Widget child,
    @required this.state,
  }) : super(key: key, child: child);

  final AuthAppState state;

  @override
  bool updateShouldNotify(_StateProvider oldWidget) {
    return true;
  }
}

class AuthAppRoutes {
  static const auth = "auth/";
  static const login = "login/";
  static const register = "register/";
  static const reset_password = "reset_password/";
}

class AuthApp extends StatefulWidget {
  @override
  AuthAppState createState() => AuthAppState();
}

class AuthAppState extends State<AuthApp> {
  static AuthAppState of([BuildContext context, bool rebuild = true]) {
    return (rebuild
            ? context.inheritFromWidgetOfExactType(_StateProvider) as _StateProvider
            : context.ancestorWidgetOfExactType(_StateProvider) as _StateProvider)
        .state;
  }

  void handleSignIn(FirebaseUser user) async {
    final state = AppState.of(context);
    state.updateCurrentUser(user);
    Navigator.of(context).pushReplacementNamed(Routes.home);
  }

  /// Auth service
  final Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return _StateProvider(
      state: this,
      child: MaterialApp(
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(), // TODO CHECK iOS
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        initialRoute: "auth/",
        routes: <String, WidgetBuilder>{
          "auth/": (BuildContext context) => AuthScreen(),
          "login/": (BuildContext context) => LoginScreen(),
          "register/": (BuildContext context) => RegisterScreen(),
          "reset_password/": (BuildContext context) => ResetPasswordScreen(),
        },
      ),
    );
  }
}
