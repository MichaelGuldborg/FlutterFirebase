class DawaPostal {
  final String href;
  final String nr;
  final String navn;

  DawaPostal({this.href, this.nr, this.navn});

  factory DawaPostal.fromJson(Map<String, dynamic> json) {
    return DawaPostal(
      href: json['href'],
      nr: json['nr'],
      navn: json['navn'],
    );
  }
}
