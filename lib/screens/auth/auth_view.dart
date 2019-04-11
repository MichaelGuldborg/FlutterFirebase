import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/rounded_button_black.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';
import 'package:flutter_firebase_app/screens/auth/login_view.dart';
import 'package:flutter_firebase_app/screens/auth/register_view.dart';

class AuthFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthScreenState state = AuthScreen.of(context, false);

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
                    // final uid = await _authService.signInAnonymously();
                    // if (uid != null) {
                    state.handleSignIn(null);
                    // }
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  text: "Login",
                  onPressed: () {
                    state.navigateTo(LoginFragment());
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  text: "signInWithGoogle",
                  onPressed: () async {
                    final user = await state.widget.auth.signInWithGoogle();
                    state.handleSignIn(user);
                  },
                ),
                SizedBox(height: 16),
                RoundedButton(
                  transparent: true,
                  text: "Register",
                  onPressed: () {
                    state.navigateTo(RegisterFragment());
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
