import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/auth/auth_widget.dart';
import 'package:flutter_firebase_app/components/text_input.dart';
import 'package:flutter_firebase_app/services/auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool acceptedTos = false;
  bool acceptedEmail = false;

  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _repeatPasswordController = TextEditingController();

    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 64,
                    ),
                    Text(
                      "Let's get started",
                      style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text("Firstly please create a user"),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // _usernameController, "Username", false
                TextInput(
                  hintText: "Username",
                  controller: _usernameController,
                ),
                TextInput(
                  hintText: "Email",
                  controller: _emailController,
                ),
                TextInput(
                  hintText: "Password",
                  controller: _passwordController,
                  obscureText: true,
                ),
                TextInput(
                  hintText: "Repeat Password",
                  controller: _repeatPasswordController,
                  obscureText: true,
                ),
                Container(
                    width: double.maxFinite,
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              acceptedTos = !acceptedTos;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8.0),
                            width: 50,
                            color: acceptedTos ? Colors.green : Colors.red,
                          ),
                        ),
                        Text("Please accept our terms of service"),
                      ],
                    )),
                Container(
                    width: double.maxFinite,
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              acceptedEmail = !acceptedEmail;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8.0),
                            width: 50,
                            color: acceptedEmail ? Colors.green : Colors.red,
                          ),
                        ),
                        Text("Please accept that we can send you emails"),
                      ],
                    )),
                Container(
                  width: double.maxFinite,
                  height: 50,
                  child: FlatButton(
                    child: Text("Register"),
                    textColor: Colors.white,
                    color: Colors.lightBlue,
                    onPressed: () async {

                      /*
                      final user = await auth.signUpWithEmail(_usernameController.text,
                          _emailController.text, _passwordController.text);
                       */
                      Navigator.of(context).pushNamed(AuthWidgetRoutes.register_zip);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
