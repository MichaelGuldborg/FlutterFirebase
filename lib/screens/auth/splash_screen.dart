import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Delay needed for screen to finnish building
    Future.delayed(const Duration(seconds: 1), handleNavigation);
  }

  handleNavigation() async {
    final currentUser = await _authService.getCurrentUser();
    if (currentUser == null) {
      Navigator.of(context).pushReplacementNamed(Routes.auth);
      return;
    }
    Navigator.of(context).pushReplacementNamed(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.auth);
                },
                child: SizedBox(
                  height: deviceSize.height / 8,
                  width: deviceSize.width / 2,
                  child: FlutterLogo(),
                ),
              ),
              true
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "flutter",
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
