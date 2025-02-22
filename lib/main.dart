import 'package:country_info_app/providers/all_countries_provider.dart';
import 'package:country_info_app/providers/theme_provider.dart';
import 'package:country_info_app/screens/country_detail_screen.dart';
import 'package:country_info_app/screens/home_screen.dart';
import 'package:country_info_app/static/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<AllCountriesProvider>(
          create: (context) => AllCountriesProvider(),
        ),
      ],
      child: const CountryInfoApp(),
    ),
  );
}

class CountryInfoApp extends StatelessWidget {
  const CountryInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return child!;
      },
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routes: {
              HomeScreen.screenId: (context) => const HomeScreen(),
              CountryDetailScreen.screenId: (context) {
                final arguments =
                    ModalRoute.of(context)!.settings.arguments as Map;

                return CountryDetailScreen(
                  country: arguments['country'],
                  // countryStates: arguments['countryStates'],
                );
              },
            },
            initialRoute: HomeScreen.screenId,
          );
        },
      ),
    );
  }
}
