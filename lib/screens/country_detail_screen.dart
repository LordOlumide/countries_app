import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/widgets/country_field.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  static const String screenId = 'country_detail_screen';

  final Country country;
  // final List<String> countryStates;

  const CountryDetailScreen({
    super.key,
    required this.country,
    // required this.countryStates,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          country.commonName,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CachedNetworkImage(
              imageUrl: country.flagEmoji,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 20),
          CountryField(
              fieldName: 'Country Name', fieldValue: country.commonName),
          const SizedBox(height: 5),
          CountryField(
              fieldName: 'Capital City',
              fieldValue: country.capital.join(', ')),
          const SizedBox(height: 5),
          CountryField(
              fieldName: 'Population',
              fieldValue: country.population.toString()),
          const SizedBox(height: 5),
          CountryField(fieldName: 'Country Code', fieldValue: country.cca3),
          const SizedBox(height: 5),
          CountryField(
              fieldName: 'Continents',
              fieldValue: country.continents.join(', ')),
          const SizedBox(height: 15),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
