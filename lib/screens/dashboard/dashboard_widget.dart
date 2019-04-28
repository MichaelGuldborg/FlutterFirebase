import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/screens/basic/base_widget.dart';
import 'package:flutter_firebase_app/screens/dashboard/bulletin_screen.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardWidgetRoutes {
  static const initial = "initial";
  static const bulletin_list = "bulletin_list";
}

class DashboardWidget extends StatefulWidget {
  @override
  DashboardWidgetState createState() => DashboardWidgetState();
}

class DashboardWidgetState extends State<DashboardWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Dashboard auth guard
    Future.delayed(const Duration(seconds: 1), () {
      if (auth.currentUser == null) {
        AppNavigator.of(context).pushReplacementNamed(AppRoutes.auth);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      initialRoute: DashboardWidgetRoutes.initial,
      initialLeading: IconButton(
          icon: Icon(FontAwesomeIcons.user, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.settings);
          }),
      routes: <String, Widget>{
        DashboardWidgetRoutes.initial: DashboardScreen(),
        DashboardWidgetRoutes.bulletin_list: BulletinScreen(),
      },
      titles: <String, String>{
        DashboardWidgetRoutes.initial: "Dashboard",
        // DashboardWidgetRoutes.bulletin_list: "Bulletins",
      },
    );
  }
}
