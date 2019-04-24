import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_button.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_widget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: <Widget>[
          DashboardButton(
            title: "Opslagstavlen",
            status: "Aktiv 28. feb.",
            onPress: () {
              DashboardWidgetState.of(context).pushNamed(DashboardWidgetRoutes.bulletin_list);
            },
          ),
          DashboardButton(title: "Skader", status: "1 aktuelle"),
          DashboardButton(title: "Kontaktbog", status: "6 kontakter"),
          DashboardButton(title: "Arkiv", status: "9 dokumenter"),
          DashboardButton(title: "Beboere", status: "3 beboere"),
          DashboardButton(title: "Vedligehold", status: "0 aktuelle"),
        ],
      ),
    );
  }
}
