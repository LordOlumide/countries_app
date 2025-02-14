import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/repos/countries_repo.dart';
import 'package:flutter/foundation.dart';

class AllCountriesProvider extends ChangeNotifier {
  List<Country> _allCountriesStore = [];
  List<Country> allCountriesDisplay = [];

  bool isInitialized = false;
  bool isLoading = false;

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
