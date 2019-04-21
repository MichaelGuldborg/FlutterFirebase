import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/suggestion_list_view.dart';
import 'package:flutter_firebase_app/components/text_input.dart';
import 'package:flutter_firebase_app/screens/auth/auth_widget.dart';
import 'package:flutter_firebase_app/services/dawa.dart';

class RegisterZipScreen extends StatefulWidget {
  @override
  _RegisterZipScreenState createState() => _RegisterZipScreenState();
}

class _RegisterZipScreenState extends State<RegisterZipScreen> {
  // TODO AUTO COMPLETE
  // https://stackoverflow.com/questions/43652460/flutter-textfield-autocomplete-overlay

  final _zipController = TextEditingController();
  List<String> suggestionList;

  @override
  Widget build(BuildContext context) {
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
                      onChanged: (text) async {
                        List<String> postalList = await dawa.getPostalAutoComplete(text);
                        setState(() {
                          suggestionList = postalList;
                        });
                      },
                    ),
                    SuggetionListView(_zipController, suggestionList),
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
                        onPressed: () async {
                          final text = _zipController.text;
                          if (text.length < 4) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Please enter a valid zip code"),
                            ));
                            return;
                          }

                          // Fetch save and navigate
                          final zipCode = text.substring(0, 4);
                          List<String> postalList = await dawa.getPostalAutoComplete(zipCode);
                          dawa.postalName = postalList[0];
                          Navigator.of(context).pushNamed(AuthWidgetRoutes.search_address);
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

