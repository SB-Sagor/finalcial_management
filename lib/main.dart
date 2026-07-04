import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/localization/app_translations.dart';
import 'data/services/storage_service.dart';
import 'features/dashboard/controllers/theme_controller.dart';
import 'navigation_menu.dart';
import 'utils/theme/app_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await Get.putAsync<StorageService>(
        () => StorageService().init(),
    permanent: true,
  );

  // Initialize Theme Controller
  Get.put<ThemeController>(
    ThemeController(),
    permanent: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.instance;

    return Obx(
          () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BusinessBro',

        // Localization
        translations: AppTranslations(),
            locale: Locale(controller.currentLanguage.value),
            fallbackLocale: const Locale('en'),

        // Themes
        theme: AppThemes.lightMode,
        darkTheme: AppThemes.darkMode,
            themeMode: controller.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,

        // Home
        home: const NavigationMenu(),
      ),
    );
  }
}