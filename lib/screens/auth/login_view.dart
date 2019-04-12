import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/rounded_button.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';
import 'package:flutter_firebase_app/screens/auth/forgot_password_view.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: LoginForm(context)));
  }

  Widget LoginForm(BuildContext context) {
    final AuthScreenState state = AuthScreenState.of(context, false);
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'email'),
            controller: _emailController,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'password'),
            controller: _passwordController,
            obscureText: true,
          ),
          SizedBox(
            height: 16,
          ),
          RoundedButton(
              text: "Login",
              onPressed: () async {
                final user = await state.auth.signInWithEmail(
                    _emailController.text, _passwordController.text);
                state.handleSignIn(user);
              }),
          FlatButton(
              onPressed: () {
                state.navigateTo(ForgotPasswordView());
              },
              child: Text("Forgot password"))
        ],
      ),
    );
  }
}
