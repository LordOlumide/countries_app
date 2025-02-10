import 'package:country_info_app/repos/countries_repo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const screenId = "Home screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CountriesRepo.getAllCountries();

    return Scaffold();
  }
}
