import 'package:flutter/material.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Axiforma'),
  );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Axiforma'),
  );
}
