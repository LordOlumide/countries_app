import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/repos/countries_repo.dart';
import 'package:flutter/material.dart';

class AllCountriesProvider extends ChangeNotifier {
  List<Country> _allCountriesStore = [];
  List<Country> allCountriesDisplay = [];

  bool isLoading = false;

  void setLoadingTo(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getAllCountries() async {
    setLoadingTo(true);
    try {
      _allCountriesStore = await CountriesRepo.getAllCountries();
      allCountriesDisplay = [..._allCountriesStore];
    } catch (error) {
      print(error);
    }
    setLoadingTo(false);
  }

  void searchCountries(String searchTerm) {
    setLoadingTo(true);
    allCountriesDisplay = _allCountriesStore
        .where(
          (country) =>
              country.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
              country.capital
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              (country.fullName != null
                  ? country.fullName!
                      .toLowerCase()
                      .contains(searchTerm.toLowerCase())
                  : false),
        )
        .toList();
    setLoadingTo(false);
  }

  void resetCountries() {
    setLoadingTo(true);
    allCountriesDisplay = [..._allCountriesStore];
    setLoadingTo(false);
  }

  Future<List<String>> getStatesInCountry(String countryName) async {
    setLoadingTo(true);
    try {
      List<String> countryStates =
          await CountriesRepo.getStatesInCountry(countryName);
      setLoadingTo(false);
      return countryStates;
    } catch (error) {
      setLoadingTo(false);
      print(error);
      rethrow;
    }
  }
}
