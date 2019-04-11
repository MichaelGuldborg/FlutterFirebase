import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<File> imageFile;

  //Open gallery
  pickImageFromGallery() {
    setState(() {
      imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseUser currentUser = AppState.of(context).currentUser;
    final String displayName =
        currentUser.displayName == null ? "" : currentUser.displayName;
    final String email = currentUser.email == null ? "" : currentUser.email;
    final String phoneNumber =
        currentUser.phoneNumber == null ? "" : currentUser.phoneNumber;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Settings", style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              onPressed: pickImageFromGallery,
              child: FutureBuilder<File>(
                future: imageFile,
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null) {
                    return Image.file(
                      snapshot.data,
                      width: 200,
                      height: 200,
                      fit: BoxFit.fitWidth,
                    );
                  } else if (snapshot.error != null) {
                    return const Text(
                      'Error Picking Image',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return Image.asset(
                      "assets/images/place_holder.jpg",
                      width: 200,
                      height: 200,
                    );
                  }
                },
              ),
            ),
            _FlatListView('Name', displayName),
            _FlatListView('Email', email),
            _FlatListView('Phone', phoneNumber),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[Text('Welcome ${currentUser?.email}!')],
    );
  }

  Widget _FlatListView(key, value) => Container(
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Colors.grey.withAlpha(70)))),
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(key,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400)),
            Text(value,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500)),
          ],
        ),
      );
}

/*
Column(
        children: <Widget>[
          Image.network("https://picsum.photos/200/300?image=0"),
          Text("Settings"),
        ],
      ),
 */
