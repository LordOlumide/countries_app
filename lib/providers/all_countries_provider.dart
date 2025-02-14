import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/repos/countries_repo.dart';
import 'package:flutter/foundation.dart';

class AllCountriesProvider extends ChangeNotifier {
  List<Country> _allCountriesStore = [];
  List<Country> allCountriesDisplay = [];

  final Set<String> allContinents = {};
  final Set<String> allTimeZones = {};

  bool isInitialized = false;
  bool isLoading = false;

  int get noOfCountriesDisplayed => allCountriesDisplay.length;

  void setLoadingTo(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getAllCountries() async {
    setLoadingTo(true);
    try {
      _allCountriesStore = await CountriesRepo.getAllCountries();
      _allCountriesStore.sort((a, b) {
        return a.commonName.toLowerCase().compareTo(b.commonName.toLowerCase());
      });
      for (Country country in _allCountriesStore) {
        allContinents.addAll(country.continents);
        allTimeZones.addAll(country.timezones);
      }
      allCountriesDisplay = [..._allCountriesStore];
      isInitialized = true;
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(error);
        print(stacktrace);
      }
    }
    setLoadingTo(false);
  }

  void searchCountries(String searchTerm) {
    setLoadingTo(true);
    allCountriesDisplay = _allCountriesStore
        .where(
          (country) =>
              country.commonName
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              country.officialName
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              country.capital
                  .where((city) =>
                      city.toLowerCase().contains(searchTerm.toLowerCase()))
                  .isNotEmpty,
        )
        .toList();
    setLoadingTo(false);
  }

  void filter(
      {required List<String> continents, required List<String> timeZones}) {
    setLoadingTo(true);
    allCountriesDisplay = _allCountriesStore.where((country) {
      for (String continent in country.continents) {
        if (continents.contains(continent)) {
          return true;
        }
      }
      for (String timeZone in country.timezones) {
        if (timeZones.contains(timeZone)) {
          return true;
        }
      }
      return false;
    }).toList();
    setLoadingTo(false);
  }

  void resetCountries() {
    setLoadingTo(true);
    allCountriesDisplay = [..._allCountriesStore];
    setLoadingTo(false);
  }

  // Future<List<String>> getStatesInCountry(String countryName) async {
  //   setLoadingTo(true);
  //   try {
  //     List<String> countryStates =
  //         await CountriesRepo.getStatesInCountry(countryName);
  //     setLoadingTo(false);
  //     return countryStates;
  //   } catch (error) {
  //     setLoadingTo(false);
  //     print(error);
  //     rethrow;
  //   }
  // }
}
