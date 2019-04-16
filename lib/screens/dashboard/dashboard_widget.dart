import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_button.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final FirebaseUser currentUser = auth.currentUser;

    final navigatorKey = new GlobalKey<NavigatorState>();

    return Scaffold(
      appBar: _appBar(navigatorKey),
      persistentFooterButtons: <Widget>[Text('Welcome ${currentUser?.email}!')],
      body: MaterialApp(
        navigatorKey: navigatorKey,
        color: Color(0xFFf5f6f8),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
        ),
        initialRoute: "initial",
        routes: <String, WidgetBuilder>{
          "initial": (BuildContext context) => _dashboardScreen(context),
          "second": (BuildContext context) => _secondRoute(context),
        },
      ),
    );
  }

  Widget _secondRoute(context) => Container(
        child: FlatButton(
            child: Text("Back"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        color: Colors.cyan,
      );

  Widget _dashboardScreen(context) => GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: <Widget>[
          DashboardButton(
            title: "Opslagstavlen",
            status: "Aktiv 28. feb.",
            onPress: () {
              Navigator.of(context).pushNamed("second");
            },
          ),
          DashboardButton(title: "Skader", status: "1 aktuelle"),
          DashboardButton(title: "Kontaktbog", status: "6 kontakter"),
          DashboardButton(title: "Arkiv", status: "9 dokumenter"),
          DashboardButton(title: "Beboere", status: "3 beboere"),
          DashboardButton(title: "Vedligehold", status: "0 aktuelle"),
        ],
      );

  Widget _appBar(GlobalKey<NavigatorState> key) => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              if (key.currentState.canPop()) {
                key.currentState.pop();
              }
            },
            child: Text("BACK")),
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
          IconButton(
            icon: Icon(FontAwesomeIcons.user, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.settings);
            },
          )
        ],
      );
}

