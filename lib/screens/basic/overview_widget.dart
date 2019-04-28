import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';

class OverviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FlatButton(
                  child: Text("Minejendom"),
                  onPressed: () {
                    AppNavigator.of(context).pushNamed(AppRoutes.dashboard);
                  }),
              FlatButton(
                  child: Text("Sidecourt"),
                  onPressed: () {
                    AppNavigator.of(context).pushNamed(AppRoutes.event_dashboard);
                  }),
              FlatButton(
                  child: Text("Chat"),
                  onPressed: () {
                    AppNavigator.of(context).pushNamed(AppRoutes.chat);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
