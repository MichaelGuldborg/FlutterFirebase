import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/rounded_button.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/screens/settings/firebase_image_picker.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final StorageReference storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    final FirebaseUser currentUser = AppState.of(context).currentUser;
    final displayName = currentUser.displayName == null ? "" : currentUser.displayName;
    final email = currentUser.email == null ? "" : currentUser.email;
    final phoneNumber = currentUser.phoneNumber == null ? "" : currentUser.phoneNumber;

    final profilePictureRef =
        storageRef.child("users").child(currentUser.uid).child("profile_picture");

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
            FirebaseImagePicker(imageRef: profilePictureRef),
            _FlatListView('Name', displayName),
            _FlatListView('Email', email),
            _FlatListView('Phone', phoneNumber),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 100),
              child: Center(
                child: RoundedButton(
                  text: "Logout",
                  onPressed: () {
                    AppState.of(context).currentUser = null;
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _FlatListView(key, value) => Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey.withAlpha(70)))),
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(key, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
            Text(value, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
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
