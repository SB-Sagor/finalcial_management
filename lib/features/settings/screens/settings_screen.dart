import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constraints/u_colors.dart';
import '../../dashboard/controllers/theme_controller.dart';
import 'widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings & Language"),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// Language
          USettingsTile(
            title: "Change Language / ভাষা পরিবর্তন",
            subtitle: "Select English or Bengali",
            icon: Iconsax.language_square,
            onTap: () => _showLanguageBottomSheet(controller),
            trailing: Obx(
                  () => Text(
                    controller.currentLanguage.value == "en"
                        ? "English"
                    : "বাংলা",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: UColors.profitGreen,
                ),
              ),
            ),
          ),

          /// Theme
          Obx(
                () => USettingsTile(
              title: "Dark Mode / নাইট মোড",
              subtitle: "Enable or Disable Dark Theme",
              icon: Iconsax.moon,
              onTap: controller.toggleTheme,
              trailing: Switch.adaptive(
                value: controller.isDarkMode.value,
                activeColor: UColors.profitGreen,
                onChanged: (_) => controller.toggleTheme(),
              ),
            ),
          ),

          USettingsTile(
            title: "Version",
            subtitle: "BusinessBro Production Build",
            icon: Iconsax.info_circle,
            onTap: () {},
            trailing: const Text(
              "v1.0.0",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet(
      ThemeController controller,
      ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select Language",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Obx(
                  () => ListTile(
                title: const Text("English"),
                trailing: controller.currentLanguage.value == "en"
                    ? const Icon(
                  Icons.check_circle,
                  color: UColors.profitGreen,
                )
                    : null,
                onTap: () {
                  controller.changeLanguage("en");
                  Get.back();
                },
              ),
            ),

            Obx(
                  () => ListTile(
                title: const Text("বাংলা"),
                trailing: controller.currentLanguage.value == "bn"
                    ? const Icon(
                  Icons.check_circle,
                  color: UColors.profitGreen,
                )
                    : null,
                onTap: () {
                  controller.changeLanguage("bn");
                  Get.back();
                },
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}