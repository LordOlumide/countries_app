import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/providers/all_countries_provider.dart';
import 'package:country_info_app/providers/theme_provider.dart';
import 'package:country_info_app/screens/components/countries_display.dart';
import 'package:country_info_app/screens/components/filter_section.dart';
import 'package:country_info_app/screens/components/home_screen_searchbar.dart';
import 'package:country_info_app/screens/country_detail_screen.dart';
import 'package:country_info_app/widgets/filters_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const screenId = "Home screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.read<AllCountriesProvider>().isInitialized == false) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.read<AllCountriesProvider>().getAllCountries();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore',
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w700),
                  ),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return IconButton(
                        onPressed: () {
                          context.read<ThemeProvider>().toggleMode();
                        },
                        icon: Icon(
                          themeProvider.isLightMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: HomeScreenSearchbar(),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Consumer<AllCountriesProvider>(
                builder: (context, countriesProvider, child) {
                  return Column(
                    children: [
                      countriesProvider.isInitialized
                          ? FilterSection(onFilterPressed: _onFilterPressed)
                          : const SizedBox(),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: CountriesDisplay(
                          countriesProvider: countriesProvider,
                          onCountryPressed: _onCountryPressed,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCountryPressed(Country country) async {
    // final List<String> countryStates = await context
    //     .read<AllCountriesProvider>()
    //     .getStatesInCountry(country.commonName);
    if (mounted) {
      Navigator.pushNamed(
        context,
        CountryDetailScreen.screenId,
        arguments: {
          'country': country,
          // 'countryStates': countryStates,
        },
      );
    }
  }

  void _onFilterPressed(BuildContext context) async {
    final Map<String, dynamic>? values = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return const FiltersBottomSheet();
      },
    );
    if (values == null) {
      return;
    }
    if (values['selectedContinents'] == null ||
        values['selectedTimeZones'] == null ||
        (List.from(values['selectedContinents']).isEmpty &&
            List.from(values['selectedTimeZones']).isEmpty)) {
      return;
    }

    if (context.mounted) {
      context.read<AllCountriesProvider>().filter(
            continents: values['selectedContinents'],
            timeZones: values['selectedTimeZones'],
          );
    }
  }
}
