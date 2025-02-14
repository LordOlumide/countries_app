import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/providers/all_countries_provider.dart';
import 'package:country_info_app/providers/theme_provider.dart';
import 'package:country_info_app/screens/country_detail_screen.dart';
import 'package:country_info_app/widgets/country_container.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  height: 1.3,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.search, size: 22.r),
                  hintText: 'Search Country',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16.sp,
                    color: context.select<ThemeProvider, bool>(
                            (provider) => provider.isLightMode)
                        ? const Color(0xFF667085)
                        : const Color(0xFFEAECF0),
                  ),
                  filled: true,
                  fillColor: context.select<ThemeProvider, bool>(
                          (provider) => provider.isLightMode)
                      ? const Color(0xFFF2F4F7)
                      : const Color(0xFF98A2B3).withValues(alpha: 0.2),
                  isDense: true,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 15.h),
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
            SizedBox(height: 16.h),
            Expanded(
              child: Consumer<AllCountriesProvider>(
                builder: (context, countriesProvider, child) {
                  return Column(
                    children: [
                      countriesProvider.isInitialized
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    onPressed: () => _onFilterPressed(context),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.filter_alt_outlined,
                                          size: 20.r,
                                        ),
                                        SizedBox(width: 11.w),
                                        Text(
                                          'Filter',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: Stack(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.only(bottom: 50.h),
                              itemCount:
                                  countriesProvider.allCountriesDisplay.length,
                              itemBuilder: (context, index) {
                                final Country country = countriesProvider
                                    .allCountriesDisplay[index];
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
