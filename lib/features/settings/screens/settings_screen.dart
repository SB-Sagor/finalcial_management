import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constraints/u_colors.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Language'),
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          USettingsTile(
            title: 'Change Language / ভাষা পরিবর্তন',
            subtitle: 'Select between English and Bengali',
            icon: Iconsax.language_square,
            onTap: () {
              _showLanguageBottomSheet(context, controller);
            },
            trailing: Obx(() => Text(
              controller.currentLanguage.value == 'en' ? 'English' : 'বাংলা',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: UColors.profitGreen),
            )),
          ),

          Obx(() => USettingsTile(
            title: 'Dark Mode / নাইট মোড',
            subtitle: 'Adjust app interface visibility',
            icon: Iconsax.moon,
            onTap: () {},
            trailing: Switch.adaptive(
              value: controller.isDarkMode.value,
              activeColor: UColors.profitGreen,
              onChanged: (value) => controller.toggleTheme(value),
            ),
          )),

          USettingsTile(
            title: 'Version Info',
            subtitle: 'BusinessBro Production Build',
            icon: Iconsax.info_circle,
            onTap: () {},
            trailing: const Text('v1.0.0', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context, SettingsController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Language / ভাষা নির্বাচন করুন',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('English (Default)'),
              trailing: Obx(() => controller.currentLanguage.value == 'en' ? const Icon(Icons.check_circle_rounded, color: UColors.profitGreen) : const SizedBox()),
              onTap: () {
                controller.toggleLanguage('en');
                Get.back();
              },
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('বাংলা (Bengali)'),
              trailing: Obx(() => controller.currentLanguage.value == 'bn' ? const Icon(Icons.check_circle_rounded, color: UColors.profitGreen) : const SizedBox()),
              onTap: () {
                controller.toggleLanguage('bn');
                Get.back();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}