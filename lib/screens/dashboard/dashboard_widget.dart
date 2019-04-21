import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/screens/dashboard/bulletin_screen.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: missing_const_final_var_or_type
abstract class PageWidget extends StatefulWidget {



}

class DashboardWidget extends StatefulWidget {
  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class DashboardWidgetRoutes {
  static const bulletin_screen = "bulletin_screen/";
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final currentUser = auth.currentUser;

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(navigatorKey),
      body: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        initialRoute: "dashboard_screen",
        routes: <String, WidgetBuilder>{
          "dashboard_screen": (BuildContext context) => DashboardScreen(),
          DashboardWidgetRoutes.bulletin_screen: (BuildContext context) => BulletinScreen(),
        },
      ),
    );
  }

  Widget _appBar(GlobalKey<NavigatorState> key) => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const BackButtonIcon(),
            color: Colors.black,
            onPressed: () {
              if (key.currentState.canPop()) {
                key.currentState.pop();
              }
            }),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              height: 50,
              alignment: Alignment.centerLeft,
              child: Text(
                "Dashboard",
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
              )),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(FontAwesomeIcons.user, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.settings);
              },
            ),
          )
        ],
      );
}
