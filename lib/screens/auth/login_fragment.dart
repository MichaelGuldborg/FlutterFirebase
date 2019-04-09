import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/rounded_button_black.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/screens/auth/auth_activity.dart';

class LoginFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: LoginForm(context)));
  }

  Widget LoginForm(BuildContext context) {
    final AuthActivityState state = AuthActivity.of(context, false);
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(8.0),
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
                final uid = await state.authService.signInWithEmail(
                    _emailController.text, _passwordController.text);
                if (uid != null) {
                  Navigator.of(context).pushReplacementNamed(Routes.home);
                }
              }),
        ],
      ),
    );
  }
}
