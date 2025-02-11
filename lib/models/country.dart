class Country {
  final String name;
  final String? fullName;
  final String statesUrl;
  final String flagUrl;
  final String population;
  final String capital;
  final String? currentPresident;
  final String continent;
  final String countryCode;

  const Country({
    required this.name,
    this.fullName,
    required this.statesUrl,
    required this.flagUrl,
    required this.population,
    required this.capital,
    this.currentPresident,
    required this.continent,
    required this.countryCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fullName': fullName,
      'statesUrl': statesUrl,
      'flagUrl': flagUrl,
      'population': population,
      'capital': capital,
      'currentPresident': currentPresident,
      'continent': continent,
      'countryCode': countryCode,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic>? currentPresident =
        map['current_president'] != null
            ? Map<String, dynamic>.from(map['current_president'])
            : null;
    final Map<String, dynamic> href = Map<String, dynamic>.from(map['href']);

    return Country(
      name: map['name'] as String,
      fullName: map['full_name'] as String?,
      statesUrl: href['states'] as String,
      flagUrl: href['flag'] as String,
      population: map['population'] as String,
      capital: map['capital'] as String,
      currentPresident:
          currentPresident != null ? currentPresident['name'] as String? : null,
      continent: map['continent'] != null ? map['continent'] as String : '',
      countryCode: map['iso3'] as String,
    );
  }
}
