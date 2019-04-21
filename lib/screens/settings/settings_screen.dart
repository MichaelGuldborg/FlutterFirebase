import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/flat_list_button.dart';
import 'package:flutter_firebase_app/components/rounded_button.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/screens/settings/firebase_image_picker.dart';
import 'package:flutter_firebase_app/services/auth.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final StorageReference storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    final FirebaseUser currentUser = auth.currentUser;
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
            Container(
              color: Colors.grey.shade100,
              padding: EdgeInsets.all(32),
              child: FirebaseImagePicker(
                imageRef: profilePictureRef,
                imageSize: 160,
              ),
            ),
            FlatListButton(label: 'Name', text: displayName, topBorder: true),
            FlatListButton(label: 'Email', text: email),
            FlatListButton(label: 'Phone', text: phoneNumber),
            FlatListButton(label: 'Password', text: "●●●●●●●●"),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 100),
              child: Center(
                child: RoundedButton(
                  text: "Logout",
                  onPressed: () {
                    auth.signOut();
                    Navigator.of(context).pushReplacementNamed(AppRoutes.auth);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
