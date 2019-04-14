import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/screens/auth/auth_view.dart';
import 'package:flutter_firebase_app/screens/auth/login_view.dart';
import 'package:flutter_firebase_app/screens/auth/register_view.dart';
import 'package:flutter_firebase_app/screens/auth/reset_password_view.dart';
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

  final AuthScreenState state;

  @override
  bool updateShouldNotify(_StateProvider oldWidget) {
    return true;
  }
}

class AuthScreen extends StatefulWidget {
  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  static AuthScreenState of([BuildContext context, bool rebuild = true]) {
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
            // TargetPlatform.iOS: CupertinoPageTransitionsBuilder(), // TODO CHECK iOS
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        home: AuthView(),
        routes: <String, WidgetBuilder>{
          "login/": (BuildContext context) => LoginView(),
          "reset_password/": (BuildContext context) => ResetPasswordView(),
          "register/": (BuildContext context) => RegisterView(),
        },
      ),
    );
  }
}
