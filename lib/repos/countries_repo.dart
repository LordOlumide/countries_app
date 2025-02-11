import 'package:country_info_app/models/country.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class CountriesRepo {
  // In a production app, I would not use flutter_dotenv to store the API key
  static String apiKey = dotenv.get('COUNTRIES_API_KEY');

  static String baseUrl = 'https://restfulcountries.com/';
  static String allCountriesEndpoint = 'api/v1/countries';

  static final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {'Authorization': 'Bearer $apiKey'},
    ),
  );

  static Future<List<Country>> getAllCountries() async {
    final response = await dio.get(allCountriesEndpoint);
    final countriesList =
        List.from(Map<String, dynamic>.from(response.data)['data']);

    final List<Country> countries = [];
    for (int i = 0; i < countriesList.length; i++) {
      final Country country = Country.fromMap(
        Map<String, dynamic>.from(countriesList[i]),
      );
      countries.add(country);
    }
    return countries;
  }

  static Future<List<String>> getStatesInCountry(String countryName) async {
    final response = await dio.get('$allCountriesEndpoint/$countryName/states');
    final statesList =
        List.from(Map<String, dynamic>.from(response.data)['data']);

    List<String> states = [];
    for (int i = 0; i < statesList.length; i++) {
      final String state = statesList[i]['name'];
      states.add(state);
    }

    return states;
  }
}
