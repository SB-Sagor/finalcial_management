import 'package:finalcial_management/utils/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/localization/app_translations.dart';
import 'data/services/storage_service.dart';
import 'features/dashboard/controllers/theme_controller.dart';
import 'navigation_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Storage Service initialization
  await Get.putAsync(() => StorageService().init());

  // Inject Theme Controller
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;

    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BusinessBro',
      translations: AppTranslations(),
      locale: Locale(themeController.currentLanguage),
      fallbackLocale: const Locale('en'),
      theme: AppThemes.lightMode,
      darkTheme: AppThemes.darkMode,
      themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const NavigationMenu(),
    ));
  }
}