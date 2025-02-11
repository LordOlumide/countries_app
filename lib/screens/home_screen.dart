import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/providers/all_countries_provider.dart';
import 'package:country_info_app/providers/theme_provider.dart';
import 'package:country_info_app/screens/country_detail_screen.dart';
import 'package:country_info_app/widgets/country_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Explore',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Country',
                  hintStyle: const TextStyle(),
                  filled: true,
                ),
                onChanged: (String? newValue) {
                  if (newValue == null || newValue.isEmpty) {
                    context.read<AllCountriesProvider>().resetCountries();
                  } else {
                    context
                        .read<AllCountriesProvider>()
                        .searchCountries(newValue);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<AllCountriesProvider>(
                builder: (context, countriesProvider, child) {
                  return Stack(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.only(bottom: 50),
                        itemCount: countriesProvider.allCountriesDisplay.length,
                        itemBuilder: (context, index) {
                          final Country country =
                              countriesProvider.allCountriesDisplay[index];
                          return CountryContainer(
                            country: country,
                            onPressed: () => _onCountryPressed(country),
                          );
                        },
                      ),
                      countriesProvider.isLoading
                          ? Positioned.fill(
                              child: ColoredBox(
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.15),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
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
    final List<String> countryStates = await context
        .read<AllCountriesProvider>()
        .getStatesInCountry(country.name);
    if (mounted) {
      Navigator.pushNamed(
        context,
        CountryDetailScreen.screenId,
        arguments: {
          'country': country,
          'countryStates': countryStates,
        },
      );
    }
  }
}
