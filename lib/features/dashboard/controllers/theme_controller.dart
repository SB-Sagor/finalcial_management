import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/storage_service.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();

  final _isDarkMode = true.obs;
  final _currentLanguage = 'en'.obs;

  bool get isDarkMode => _isDarkMode.value;
  String get currentLanguage => _currentLanguage.value;

  @override
  void onInit() {
    super.onInit();
    _isDarkMode.value = StorageService.instance.getThemeMode();
    _currentLanguage.value = StorageService.instance.getLanguage();

    // Set initial configuration
    Get.updateLocale(Locale(_currentLanguage.value));
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    StorageService.instance.saveThemeMode(_isDarkMode.value);
  }

  void changeLanguage(String langCode) {
    _currentLanguage.value = langCode;
    Get.updateLocale(Locale(langCode));
    StorageService.instance.saveLanguage(langCode);
  }
}