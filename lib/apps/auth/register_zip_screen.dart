import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/apps/auth/auth_app.dart';
import 'package:flutter_firebase_app/components/text_input.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RegisterZipScreen extends StatefulWidget {
  @override
  _RegisterZipScreenState createState() => _RegisterZipScreenState();
}

class _RegisterZipScreenState extends State<RegisterZipScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO AUTO COMPLETE
    // https://stackoverflow.com/questions/43652460/flutter-textfield-autocomplete-overlay
    final _zipController = TextEditingController();

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
                      "Find postal code",
                      style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                    SizedBox(height: 16.0),
                    Text("What is your postal code?"),
                    SizedBox(height: 64),
                    TextInput(
                      hintText: "Enter your zip code",
                      textInputType: TextInputType.number,
                      controller: _zipController,
                      onChanged: (String text) async {
                        final number = text.length < 4 ? text : text.substring(0, 4);
                        final requestUrl = "https://dawa.aws.dk/postnumre/autocomplete?q=$number";

                        http.Response response = await http.get(requestUrl);
                        if (response.statusCode == 200) {
                          // TODO FIX
                          var jsonResponse = convert.jsonDecode(response.body);
                          var t = jsonResponse['tekst'];
                          print(t);
                        }
                      },
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
                        child: Text("Next"),
                        textColor: Colors.white,
                        color: Colors.lightBlue,
                        onPressed: () {
                          if (_zipController.text.length < 4) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Please enter a valid zip code"),
                            ));
                            return;
                          }
                          final zipCode = _zipController.text.substring(0, 4);
                          print("zipCode");
                          print(zipCode);
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
