import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/bloc/authentication/authentication.dart';
import 'package:flutter_firebase_app/components/rounded_button_black.dart';

class RegisterScreen extends StatelessWidget {
  final AuthenticationBloc _authBloc;

  RegisterScreen({@required AuthenticationBloc authBloc})
      : assert(authBloc != null),
        _authBloc = authBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: RegisterForm(context)));
  }

  Widget RegisterForm(BuildContext context) {
    final _usernameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'username'),
            controller: _usernameController,
          ),
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
              text: "Register",
              onPressed: () {
                _authBloc.dispatch(SignUpWithEmail(
                  username: _usernameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                ));
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
