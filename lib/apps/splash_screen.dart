import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/apps/auth/auth_app.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/services/auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Delay for visual effect
    Future.delayed(const Duration(seconds: 1), handleNavigation);
  }

  void handleNavigation() async {

    final currentUser = await Auth().getCurrentUser();
    final AppState state = AppState.of(context);
    state.updateCurrentUser(currentUser);
    final route = currentUser == null ? Routes.auth : Routes.home;
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
