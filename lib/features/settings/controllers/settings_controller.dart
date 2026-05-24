import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  RxString currentLanguage = 'en'.obs;
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Synchronizes the switch state with the actual system or active app theme mode upon initialization
    isDarkMode.value = Get.isDarkMode;
  }

  void toggleLanguage(String langCode) {
    currentLanguage.value = langCode;
    Get.updateLocale(Locale(langCode));
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    if (value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }
}