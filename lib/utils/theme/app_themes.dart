import 'package:flutter/material.dart';
import '../constraints/u_colors.dart';

class AppThemes {
  AppThemes._();

  static ThemeData lightMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: UColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: UColors.profitGreen,
      secondary: UColors.accentGold,
      surface: UColors.surfaceLight,
      onSurface: UColors.textPrimaryLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: UColors.backgroundLight,
      elevation: 0,
      iconTheme: IconThemeData(color: UColors.textPrimaryLight),
      titleTextStyle: TextStyle(
        color: UColors.textPrimaryLight,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: UColors.textPrimaryLight),
      bodyMedium: TextStyle(color: UColors.textPrimaryLight),
    ),
  );

  static ThemeData darkMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: UColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: UColors.profitGreen,
      secondary: UColors.accentGold,
      surface: UColors.surfaceDark,
      onSurface: UColors.textPrimaryDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: UColors.backgroundDark,
      elevation: 0,
      iconTheme: IconThemeData(color: UColors.textPrimaryDark),
      titleTextStyle: TextStyle(
        color: UColors.textPrimaryDark,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: UColors.textPrimaryDark),
      bodyMedium: TextStyle(color: UColors.textPrimaryDark),
    ),
  );
}