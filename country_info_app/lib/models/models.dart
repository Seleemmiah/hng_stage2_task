class Country {
  final String name;
  final String flag;
  final String capital;
  final String region;
  final String countryCode;
  final int? population;

  Country({
    required this.name,
    required this.flag,
    required this.capital,
    required this.region,
    required this.countryCode,
    this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"]["common"],
      flag: json["flags"]["png"],
      capital: (json["capital"] != null) ? json["capital"][0] : "N/A",
      region: json["region"],
      countryCode: json["cca2"],
      population: json["population"],
    );
  }
}
