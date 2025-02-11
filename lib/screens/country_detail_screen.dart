import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/widgets/country_field.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  static const String screenId = 'country_detail_screen';

  final Country country;
  final List<String> countryStates;

  const CountryDetailScreen({
    super.key,
    required this.country,
    required this.countryStates,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          country.name,
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
              imageUrl: country.flagUrl,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 20),
          CountryField(fieldName: 'Country Name', fieldValue: country.name),
          const SizedBox(height: 5),
          CountryField(fieldName: 'Capital City', fieldValue: country.capital),
          const SizedBox(height: 5),
          CountryField(fieldName: 'Population', fieldValue: country.population),
          const SizedBox(height: 5),
          CountryField(
            fieldName: 'Current President',
            fieldValue: country.currentPresident ?? '',
          ),
          const SizedBox(height: 5),
          CountryField(
              fieldName: 'Country Code', fieldValue: country.countryCode),
          const SizedBox(height: 5),
          CountryField(fieldName: 'Continent', fieldValue: country.continent),
          const SizedBox(height: 15),
          const Text(
            'States',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          for (int i = 0; i < countryStates.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 4),
              child: Text(
                '${i + 1}. ${countryStates[i]}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
