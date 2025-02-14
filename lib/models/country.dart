class Country {
  final String commonName;
  final String officialName;
  final String cca2;
  final String? ccn3;
  final String cca3;
  final bool? independent;
  final String status;
  final bool unMember;
  final Map<String, Map<String, String>> currencies;
  final List<String> capital;
  final String region;
  final Map<String, String> languages;
  final Map<String, Map<String, String>> translations;
  final List<double> latlng;
  final bool? landLocked;
  final String flagEmoji;
  final Map<String, String> maps;
  final int population;
  final List<String> timezones;
  final List<String> continents;
  final String flagUrl;
  final String? coatOfArmsUrl;
  final String startOfWeek;

  Country({
    required this.commonName,
    required this.officialName,
    required this.cca2,
    required this.ccn3,
    required this.cca3,
    required this.independent,
    required this.status,
    required this.unMember,
    required this.currencies,
    required this.capital,
    required this.region,
    required this.languages,
    required this.translations,
    required this.latlng,
    required this.landLocked,
    required this.flagEmoji,
    required this.maps,
    required this.population,
    required this.timezones,
    required this.continents,
    required this.flagUrl,
    required this.coatOfArmsUrl,
    required this.startOfWeek,
  });

  Map<String, dynamic> toMap() {
    return {
      'commonName': commonName,
      'officialName': officialName,
      'cca2': cca2,
      'ccn3': ccn3,
      'cca3': cca3,
      'independent': independent,
      'status': status,
      'unMember': unMember,
      'currencies': currencies,
      'capital': capital,
      'region': region,
      'languages': languages,
      'translations': translations,
      'latlng': latlng,
      'landLocked': landLocked,
      'flag': flagEmoji,
      'maps': maps,
      'population': population,
      'timezones': timezones,
      'continents': continents,
      'flagUrl': flagUrl,
      'coatOfArms': coatOfArmsUrl,
      'startOfWeek': startOfWeek,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    final nameMap = Map<String, dynamic>.from(map['name']);
    final Map<String, Map<String, String>> currencies = {};
    if (map['currencies'] != null) {
      Map<String, dynamic>.from(map['currencies'])
          .forEach((String key, dynamic value) {
        currencies[key] = Map<String, String>.from(value);
      });
    }

    final Map<String, Map<String, String>> translations = {};
    Map<String, dynamic>.from(map['translations'])
        .forEach((String key, dynamic value) {
      translations[key] = Map<String, String>.from(value);
    });

    return Country(
      commonName: nameMap['common'] as String,
      officialName: nameMap['official'] as String,
      cca2: map['cca2'] as String,
      ccn3: map['ccn3'] as String?,
      cca3: map['cca3'] as String,
      independent: map['independent'] as bool?,
      status: map['status'] as String,
      unMember: map['unMember'] as bool,
      currencies: currencies,
      capital: map['capital'] != null ? List<String>.from(map['capital']) : [],
      region: map['region'] as String,
      languages: map['languages'] != null
          ? Map<String, String>.from(map['languages'])
          : {},
      translations: translations,
      latlng: List<double>.from(map['latlng'], growable: false),
      landLocked: map['landLocked'] as bool?,
      flagEmoji: map['flag'] as String,
      maps: Map<String, String>.from(map['maps']),
      population: map['population'] as int,
      timezones: List<String>.from(map['timezones'], growable: false),
      continents: List<String>.from(map['continents'], growable: false),
      flagUrl: map['flags']['png'] as String,
      coatOfArmsUrl:
          Map<String, dynamic>.from(map['coatOfArms'])['png'] as String?,
      startOfWeek: map['startOfWeek'] as String,
    );
  }
}
