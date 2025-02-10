import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class CountriesRepo {
  // In a production app, I would not use flutter_dotenv to store the API key
  static String apiKey = dotenv.get('COUNTRIES_API_KEY');

  static String baseUrl = dotenv.get('BASE_URL');
  static String allCountriesEndpoint = dotenv.get('COUNTRIES_ENDPOINT');

  static final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
    ),
  );

  static Future<void> getAllCountries() async {
    final response = await dio.get(allCountriesEndpoint);
    print(response);
  }
}
