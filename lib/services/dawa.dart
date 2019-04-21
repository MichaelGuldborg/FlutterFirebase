import 'dart:convert' as convert;

import 'package:flutter_firebase_app/models/dawa_address.dart';
import 'package:flutter_firebase_app/models/dawa_autocomplete_address.dart';
import 'package:flutter_firebase_app/models/dawa_autocomplete_postal.dart';
import 'package:http/http.dart' as http;

class DawaService {
  String postalName;
  String address;
  List<String> addressList;

  Future<List<String>> getPostalAutoComplete(String text) async {
    final number = text.length < 4 ? text : text.substring(0, 4);
    final requestUrl = "https://dawa.aws.dk/postnumre/autocomplete?q=$number";

    http.Response response = await http.get(requestUrl);
    if (response.statusCode != 200) {
      return null;
    }

    List responseList = convert.jsonDecode(response.body) as List;
    List<String> postalList =
        responseList.map((item) => DawaAutoCompletePostal.fromJson(item).tekst).toList();
    postalList.removeWhere((suggestion) => text.contains(suggestion));
    return postalList;
  }

  Future<List<String>> getAddressAutoComplete(String text) async {
    final zipCode = postalName.substring(0, 4);
    String requestUrl = "https://dawa.aws.dk/vejnavne/autocomplete?fuzzy&postnr=$zipCode&q=$text";

    http.Response response = await http.get(requestUrl);
    if (response.statusCode != 200) {
      return null;
    }

    List responseList = convert.jsonDecode(response.body) as List;
    List<String> addressList =
        responseList.map((item) => DawaAutoCompleteAddress.fromJson(item).tekst).toList();
    addressList.removeWhere((suggestion) => text.contains(suggestion));
    return addressList;
  }

  Future<List<String>> getAddressList(String text) async {
    final zipCode = postalName.substring(0, 4);
    String requestUrl = "https://dawa.aws.dk/adresser?postnr=$zipCode&q=$text";

    http.Response response = await http.get(requestUrl);
    if (response.statusCode != 200) {
      return null;
    }

    List responseList = convert.jsonDecode(response.body) as List;

    List<String> addressList =
        responseList.map((item) => DawaAddress.fromJson(item).label).toList();

    // Sort list
    addressList.sort((a, b) {
      if(!a.contains(",") || !b.contains(",")){
        return 0;
      }

      String aFloor = a.substring(a.indexOf(",")).replaceAll("st", "0").replaceAll(RegExp("\\D"), "");
      String bFloor = b.substring(a.indexOf(",")).replaceAll("st", "0").replaceAll(RegExp("\\D"), "");
      return int.parse(aFloor) - int.parse(bFloor);
    });

    return addressList;
  }
}

final dawa = DawaService();
