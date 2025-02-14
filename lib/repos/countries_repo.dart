import 'package:country_info_app/models/country.dart';
import 'package:dio/dio.dart';

abstract class CountriesRepo {
  static String baseUrl = 'https://restcountries.com/';
  static String allCountriesEndpoint = 'v3.1/all';

  static final dio = Dio(
    BaseOptions(baseUrl: baseUrl),
  );

  static Future<List<Country>> getAllCountries() async {
    final response = await dio.get(allCountriesEndpoint);
    final countriesList = List.from(response.data);

    final List<Country> countries = [];
    for (int i = 0; i < countriesList.length; i++) {
      final Country country = Country.fromMap(
        Map<String, dynamic>.from(countriesList[i]),
      );
      print(country.officialName);
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
