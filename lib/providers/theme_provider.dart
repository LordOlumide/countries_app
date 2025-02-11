import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  bool get isLightMode => _themeMode == ThemeMode.light;

  void switchToDarkMode() {
    if (_themeMode == ThemeMode.dark) {
      return;
    }
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  void switchToLightMode() {
    if (_themeMode == ThemeMode.light) {
      return;
    }
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  void toggleMode() {
    if (_themeMode == ThemeMode.light) {
      switchToDarkMode();
    } else {
      switchToLightMode();
    }
  }
}
