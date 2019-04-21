class DawaAutoCompleteAddress {
  final String tekst;
  final DawaStreetName vejnavn;

  DawaAutoCompleteAddress({this.tekst, this.vejnavn});

  factory DawaAutoCompleteAddress.fromJson(Map<String, dynamic> json) {
    return DawaAutoCompleteAddress(
      tekst: json['tekst'],
      vejnavn: DawaStreetName.fromJson(json['vejnavn']),
    );
  }
}

class DawaStreetName {
  final String href;
  final String navn;

  DawaStreetName({this.href, this.navn});

  factory DawaStreetName.fromJson(Map<String, dynamic> json) {
    return DawaStreetName(
      href: json['href'],
      navn: json['navn'],
    );
  }
}
