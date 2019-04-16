import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/auth/auth_app.dart';
import 'package:flutter_firebase_app/components/text_input.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:flutter_firebase_app/services/dawa.dart';

class PickAddressScreen extends StatefulWidget {
  @override
  _PickAddressScreenState createState() => _PickAddressScreenState();
}

class _PickAddressScreenState extends State<PickAddressScreen> {
  final _addressController = TextEditingController();

  List<String> addressList = dawa.addressList;

  /*

   */

  @override
  Widget build(BuildContext context) {
    final AuthScreenState appState = AuthScreenState.of(context);

    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 64),
                    Text(
                      "Pick your address",
                      style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                    SizedBox(height: 16.0),
                    Text("More than one address was found please pick from the list"),
                    SizedBox(height: 64),
                    Expanded(
                      child: ListView(children:
                        addressList
                            .map((String text) =>
                            ListTile(title: Text(text), dense: true, onTap: () {
                              appState.handleSignIn(auth.currentUser);
                            }))
                            .toList()
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: double.maxFinite,
                    height: 50,
                    child: Builder(builder: (BuildContext context) {
                      return FlatButton(
                        child: Text("Search for address"),
                        textColor: Colors.white,
                        color: Colors.lightBlue,
                        onPressed: () async {

                        },
                      );
                    })),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
