import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';

class SplashActivity extends StatefulWidget {
  @override
  _SplashActivityState createState() => _SplashActivityState();
}

class _SplashActivityState extends State<SplashActivity> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Delay for visual effect
    Future.delayed(const Duration(seconds: 1), handleNavigation);
    // handleNavigation();
  }

  void handleNavigation() async {
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
            ],
          ),
        ),
      ),
    );
  }
}
