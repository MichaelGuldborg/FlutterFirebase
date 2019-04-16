import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/apps/auth/auth_app.dart';
import 'package:flutter_firebase_app/components/text_input.dart';
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
                      onChanged: (String text) async {
                        List<String> postalList = await dawa.getPostalAutoComplete(text);
                        setState(() {
                          suggestionList = postalList;
                        });
                      },
                    ),
                    suggestionList == null ? Container() : getTextWidgets(suggestionList),
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
                          final text = _zipController.text;
                          if (text.length < 4) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Please enter a valid zip code"),
                            ));
                            return;
                          }
                          dawa.postalName = text;
                          Navigator.of(context).pushNamed(AuthAppRoutes.search_address);
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

  Widget getTextWidgets(List<String> strings) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: strings
            .map((String text) => ListTile(
                title: Text(text),
                dense: true,
                onTap: () {
                  _zipController.text = text;
                  setState(() {
                    suggestionList = null;
                  });
                }))
            .toList());
  }
}
