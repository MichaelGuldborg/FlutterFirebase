import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/rounded_card.dart';

class BulletinScreen extends StatelessWidget {
  final labels = ["Ulæste", "Bestyrelsen", "Alle"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: labels.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: TabBar(
              tabs: labels.map((text) => _tabButton(text)).toList(),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RoundedCard(
                    title: "Velkommen til Minejendom!",
                    subTitle: "MinEjendom",
                    date: "28. feb",
                  ),
                ],
              ),
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(text) => Container(
      height: kToolbarHeight,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ));
}
