import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthScreenState state = AuthScreenState.of(context, false);
    final _emailController = TextEditingController();
    String errorText = null;

    return Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              errorText: errorText,
            ),
            controller: _emailController,
            onFieldSubmitted: (test) {
              final email = test.trim();
              if (!email.contains('@')) {
                return;
              }

              state.auth.sendPasswordResetEmail(email);
              state.backPressed();
            },
          ),
        ));
  }
}
