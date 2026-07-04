import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/storage_service.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find<ThemeController>();

  final RxBool isDarkMode = false.obs;
  final RxString currentLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();

    isDarkMode.value = StorageService.instance.getThemeMode();
    currentLanguage.value = StorageService.instance.getLanguage();

    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );

    Get.updateLocale(
      Locale(currentLanguage.value),
    );
  }

  Future<void> toggleTheme() async {
    isDarkMode.toggle();

    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );

    await StorageService.instance.saveThemeMode(isDarkMode.value);
  }

  Future<void> changeLanguage(String lang) async {
    currentLanguage.value = lang;

    Get.updateLocale(Locale(lang));

    await StorageService.instance.saveLanguage(lang);
  }
}