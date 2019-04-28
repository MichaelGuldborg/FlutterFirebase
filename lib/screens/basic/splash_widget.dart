import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/services/auth.dart';

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Delay for visual effect
    Future.delayed(const Duration(seconds: 1), handleNavigation);
  }

  void handleNavigation() async {
    FirebaseUser currentUser = await auth.getCurrentUser();
    print("currentUser");
    print(currentUser);
    final route = currentUser == null ? AppRoutes.auth : AppRoutes.overview;
    Navigator.of(context).pushReplacementNamed(route);
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
              SizedBox(
                height: deviceSize.height / 8,
                width: deviceSize.width / 2,
                child: FlutterLogo(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
