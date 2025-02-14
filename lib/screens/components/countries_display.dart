import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/providers/all_countries_provider.dart';
import 'package:country_info_app/widgets/country_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountriesDisplay extends StatelessWidget {
  final AllCountriesProvider countriesProvider;
  final Function(Country) onCountryPressed;

  const CountriesDisplay({
    super.key,
    required this.countriesProvider,
    required this.onCountryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(bottom: 50.h),
          itemCount: countriesProvider.allCountriesDisplay.length,
          itemBuilder: (context, index) {
            final Country country =
                countriesProvider.allCountriesDisplay[index];
            return CountryContainer(
              country: country,
              onPressed: () => onCountryPressed(country),
            );
          },
        ),
        countriesProvider.isLoading
            ? Positioned.fill(
                child: ColoredBox(
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withValues(alpha: 0.15),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
