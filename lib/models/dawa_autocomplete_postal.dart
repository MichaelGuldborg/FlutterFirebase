class DawaPostalResponse {
  final String tekst;
  final DawaPostal postnummer;

  DawaPostalResponse({this.tekst, this.postnummer});

  factory DawaPostalResponse.fromJson(Map<String, dynamic> json) {
    return new DawaPostalResponse(
      tekst: json['tekst'],
      postnummer: DawaPostal.fromJson(json['postnummer']),
    );
  }
}

class DawaPostal {
  final String href;
  final String nr;
  final String navn;

  DawaPostal({this.href, this.nr, this.navn});

  factory DawaPostal.fromJson(Map<String, dynamic> json) {
    return new DawaPostal(
      href: json['href'],
      nr: json['nr'],
      navn: json['navn'],
    );
  }
}
