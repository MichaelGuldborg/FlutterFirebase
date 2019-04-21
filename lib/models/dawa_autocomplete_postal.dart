import 'package:flutter_firebase_app/models/dawa_postal.dart';

class DawaAutoCompletePostal {
  final String tekst;
  final DawaPostal postnummer;

  DawaAutoCompletePostal({this.tekst, this.postnummer});

  factory DawaAutoCompletePostal.fromJson(Map<String, dynamic> json) {
    return DawaAutoCompletePostal(
      tekst: json['tekst'],
      postnummer: DawaPostal.fromJson(json['postnummer']),
    );
  }
}

