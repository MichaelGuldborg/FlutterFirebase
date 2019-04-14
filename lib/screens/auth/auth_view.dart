import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/rounded_button.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';

class AuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthScreenState state = AuthScreenState.of(context, false);

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
                  text: "Login",
                  onPressed: () {
                    Navigator.of(context).pushNamed("login/");
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  text: "signInWithGoogle",
                  onPressed: () async {
                    final user = await state.auth.signInWithGoogle();
                    state.handleSignIn(user);
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  transparent: true,
                  text: "Register",
                  onPressed: () {
                    Navigator.of(context).pushNamed("register/");
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
