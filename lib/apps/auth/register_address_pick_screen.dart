import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/text_input.dart';
import 'package:flutter_firebase_app/services/dawa.dart';

class PickAddressScreen extends StatefulWidget {
  @override
  _PickAddressScreenState createState() => _PickAddressScreenState();
}

class _PickAddressScreenState extends State<PickAddressScreen> {
  final _addressController = TextEditingController();
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
                      dawa.postalName,
                      style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                    SizedBox(height: 16.0),
                    Text("Pick your address"),
                    SizedBox(height: 64),
                    TextInput(
                      hintText: "More than one address was found please pick from the list",
                      controller: _addressController,
                      onChanged: (String text) async {
                        if (text.contains(",")) {
                          return;
                        }
                        List<String> postalList = await dawa.getAddressAutoComplete(text);
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
                        child: Text("Search for address"),
                        textColor: Colors.white,
                        color: Colors.lightBlue,
                        onPressed: () async {
                          final text = _addressController.text;
                          if (!text.contains(",") || text.replaceAll(RegExp(r'\D'), "").isEmpty) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Please enter a valid address"),
                            ));
                            return;
                          }

                          // TODO save and navigate
                          await dawa.getAddressList(text);
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
                  _addressController.text = text;
                  setState(() {
                    suggestionList = null;
                  });
                }))
            .toList());
  }
}
