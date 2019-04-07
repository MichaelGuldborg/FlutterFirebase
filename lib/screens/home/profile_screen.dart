import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileScreen'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.network("https://picsum.photos/250?image=10"),
            Center(
              child: Text("ProfileScreen", style: TextStyle(fontSize: 35.0)),
            ),
          ],
        ),
      ),
    );
  }
}
