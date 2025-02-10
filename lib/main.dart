import 'package:country_info_app/providers/theme_provider/theme_provider.dart';
import 'package:country_info_app/screens/home_screen.dart';
import 'package:country_info_app/static/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: "debug.env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          routes: {
            HomeScreen.screenId: (context) => const HomeScreen(),
          },
          initialRoute: HomeScreen.screenId,
        );
      },
    );
  }
}
