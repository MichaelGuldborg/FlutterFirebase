import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/rounded_card.dart';
import 'package:flutter_firebase_app/screens/auth/auth_widget.dart';
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
    final AuthWidgetState appState = AuthWidgetState.of(context);

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
                      child: ListView(
                          children: addressList
                              .map((String text) => RoundedCard(
                                    title: text,
                                    subTitle: dawa.postalName,
                                    onPress: () {
                                      // Handle address picked
                                      print("Address");
                                      print(text);
                                    },
                                  ))
                              .toList()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
