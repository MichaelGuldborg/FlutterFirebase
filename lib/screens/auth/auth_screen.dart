import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/auth/auth_app.dart';
import 'package:flutter_firebase_app/components/rounded_button.dart';
import 'package:flutter_firebase_app/services/auth.dart';

// TODO Add version name in debug
// https://stackoverflow.com/questions/53672171/how-to-get-build-and-version-number-of-flutter-app

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthScreenState appState = AuthScreenState.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlutterLogo(
                  size: 80.0,
                ),
                _appVersionText(),
                SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RoundedButton(
                  text: "Login",
                  onPressed: () {
                    Navigator.of(context).pushNamed(AuthAppRoutes.login);
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  text: "signInWithGoogle",
                  onPressed: () async {
                    final user = await auth.signInWithGoogle();
                    appState.handleSignIn(user);
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  transparent: true,
                  text: "Register",
                  onPressed: () {
                    Navigator.of(context).pushNamed(AuthAppRoutes.register);
                  },
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _appVersionText() => kReleaseMode
      ? Container()
      : Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "DEV VERSION 1.0.0",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ));
}
