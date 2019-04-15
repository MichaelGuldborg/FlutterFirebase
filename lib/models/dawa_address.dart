class DawaAddressResponse {
  final String tekst;
  final DawaStreetName vejnavn;

  DawaAddressResponse({this.tekst, this.vejnavn});

  factory DawaAddressResponse.fromJson(Map<String, dynamic> json) {
    return DawaAddressResponse(
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
