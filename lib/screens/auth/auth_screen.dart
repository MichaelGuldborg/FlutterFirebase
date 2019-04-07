import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/rounded_button_black.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';

class AuthScreen extends StatelessWidget {
  AuthService _authService = AuthService();

  // TODO Make widget an inherited widget
  // https://medium.com/flutter-community/widget-state-buildcontext-inheritedwidget-898d671b7956


  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 16),
                Text(
                  "Flutter App",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RoundedButton(
                  text: "signInAnonymously",
                  onPressed: () async {
                    final uid = await _authService.signInAnonymously();
                    if (uid != null) {
                      Navigator.of(context).pushReplacementNamed(Routes.home);
                    }
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  text: "Login",
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  text: "signInWithGoogle",
                  onPressed: () async {
                    final uid = await _authService.signInWithGoogle();
                    if (uid != null) {
                      Navigator.of(context).pushReplacementNamed(Routes.home);
                    }
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  transparent: true,
                  text: "Register",
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.register);
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
}
