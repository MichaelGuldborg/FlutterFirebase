import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';
import 'package:flutter_firebase_app/screens/auth/login_screen.dart';
import 'package:flutter_firebase_app/screens/auth/register_screen.dart';
import 'package:flutter_firebase_app/screens/auth/reset_password_screen.dart';
import 'package:flutter_firebase_app/screens/address/search_address_screen.dart';
import 'package:flutter_firebase_app/screens/address/search_zip_screen.dart';
import 'package:flutter_firebase_app/screens/address/select_address_screen.dart';

class AddressWidgetRoutes {
  static const register_zip = "register_zip";
  static const search_address = "search_address";
  static const pick_address = "pick_address";
}

class AddressWidget extends StatefulWidget {
  @override
  AddressWidgetState createState() => AddressWidgetState();
}

class AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      initialRoute: AddressWidgetRoutes.register_zip,
      routes: <String, WidgetBuilder>{
        AddressWidgetRoutes.register_zip: (BuildContext context) => RegisterZipScreen(),
        AddressWidgetRoutes.search_address: (BuildContext context) => SearchAddressScreen(),
        AddressWidgetRoutes.pick_address: (BuildContext context) => PickAddressScreen(),
      },
    );
  }
}
