import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_app/bloc/authentication/authentication.dart';
import 'package:flutter_firebase_app/components/rounded_button_black.dart';
import 'package:flutter_firebase_app/screens/auth/login_screen.dart';
import 'package:flutter_firebase_app/screens/auth/register_screen.dart';

class AuthScreen extends StatelessWidget {
  final AuthenticationBloc _authBloc;

  AuthScreen({@required AuthenticationBloc authBloc})
      : assert(authBloc != null),
        _authBloc = authBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: _authBloc,
        child: Column(
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
                    onPressed: () {
                      _authBloc.dispatch(SignInAnonymously());
                    },
                  ),
                  SizedBox(height: 16),
                  RoundedButton(
                    text: "Login",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen(authBloc: _authBloc)),
                      );
                      //await _userRepository.signInAnonymously();
                      //_authBloc.dispatch(Login());
                    },
                  ),
                  SizedBox(height: 16),
                  RoundedButton(
                    text: "Login With Google",
                    onPressed: () {
                      _authBloc.dispatch(SignInWithGoogle());
                    },
                  ),
                  SizedBox(height: 16),
                  RoundedButton(
                    transparent: true,
                    text: "Register",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterScreen(authBloc: _authBloc)),
                      );
                    },
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
