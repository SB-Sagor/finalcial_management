// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.green,
    secondaryContainer: Colors.green.shade100,
    error: Colors.red,
    errorContainer: Colors.red.shade100,
    surface: Colors.blue.shade50,
    surfaceVariant: Colors.grey.shade200,
    onPrimary: Colors.black,
    onSecondaryContainer: Colors.black,
    onErrorContainer: Colors.black,
  ),
  cardTheme: CardThemeData(
    color: Colors.white70,
    elevation: 3,
    shadowColor: Colors.grey.withOpacity(0.3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.all(8),
    clipBehavior: Clip.antiAlias,
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.teal,
    secondary: Colors.greenAccent,
    secondaryContainer: Colors.teal.shade700,
    error: Colors.redAccent,
    errorContainer: Colors.red.shade700,
    surface: Colors.grey.shade900,
    surfaceVariant: Colors.grey.shade800,
    onPrimary: Colors.white,
    onSecondaryContainer: Colors.black,
    onErrorContainer: Colors.white,
  ),
  // Use a dark card color for proper contrast in dark mode
  cardTheme: CardThemeData(
    color: Colors.black12,
    elevation: 3,
    shadowColor: Colors.black54.withOpacity(0.4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.all(8),
    clipBehavior: Clip.antiAlias,
  ),
);

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;
  bool get isLightMode => _themeData == lightMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> toggleTheme() async {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    await _saveTheme();
  }

  Future<void> _saveTheme() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isLightMode', isLightMode);
  }

  Future<void> _loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    final saved = pref.getBool('isLightMode');
    if (saved == null || saved == true) {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }
  }
}
