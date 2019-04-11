import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/services/auth.dart';

class SplashScreen extends StatefulWidget {
  final Auth auth;
  final FirebaseUserCallback signIn;

  SplashScreen({@required this.auth, this.signIn});

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
    final currentUser = await widget.auth.getCurrentUser();
    super.widget.signIn(currentUser);
    String route = currentUser == null ? Routes.auth : Routes.home;
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
