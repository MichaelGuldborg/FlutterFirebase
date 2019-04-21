import 'package:flutter_firebase_app/models/dawa_postal.dart';

class DawaAddress {
  String etage;
  String door;
  String adressebetegnelse;
  DawaAccessAddress adgangsadresse;

  DawaAddress({this.etage, this.door, this.adressebetegnelse, this.adgangsadresse});

  factory DawaAddress.fromJson(Map<String, dynamic> json) {
    return DawaAddress(
      etage: json['etage'],
      door: json['dør'],
      adressebetegnelse: json['adressebetegnelse'],
      adgangsadresse: DawaAccessAddress.fromJson(json['adgangsadresse']),
    );
  }

  String get label {
    String result = "";
    result += adgangsadresse.vejstykke + " ";
    result += adgangsadresse.husnr;

    if (door != null || etage != null) {
      result += ", ";
    }

    result += etage != null ? (etage + ". ") : "";
    result += door != null ? door : "";
    return result.trim();
  }


}

class DawaAccessAddress {
  final String husnr;
  final String vejstykke;
  final DawaPostal postnummer;

  DawaAccessAddress({this.husnr, this.vejstykke, this.postnummer});

  factory DawaAccessAddress.fromJson(Map<String, dynamic> json) {
    return DawaAccessAddress(
      husnr: json['husnr'],
      vejstykke: json['vejstykke']['navn'],
      postnummer: DawaPostal.fromJson(json['postnummer']),
    );
  }
}
