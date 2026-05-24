import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constraints/u_colors.dart';
import 'features/dashboard/screens/home/home_screen.dart';
import 'features/dashboard/screens/reports/screens/ledger_transactions_screen.dart';
import 'features/people/screens/people_screen.dart';

class DummyFeedScreen extends StatelessWidget {
  const DummyFeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.video_play, size: 50, color: UColors.profitGreen),
            SizedBox(height: 12),
            Text(
              'ভিডিও ও লাইভ সাইট ফিড (ইউজার ও ক্লায়েন্ট পোস্ট)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('এখানে পাথর/বালুর ভিডিও এবং পোস্ট স্ক্রোল হবে', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    final Color unselectedIconColor = isLight ? UColors.textSecondaryLight : UColors.textSecondaryDark;

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isLight ? Colors.grey.shade200 : UColors.borderDark,
                width: 1,
              ),
            ),
          ),
          child: NavigationBar(
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            backgroundColor: theme.scaffoldBackgroundColor,
            indicatorColor: isLight ? Colors.grey.shade200 : UColors.surface2Dark,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                icon: Icon(Iconsax.home, color: unselectedIconColor),
                selectedIcon: const Icon(Iconsax.home5, color: UColors.profitGreen),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.video, color: unselectedIconColor),
                selectedIcon: const Icon(Iconsax.video5, color: UColors.profitGreen),
                label: 'Feed',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.tag_user, color: unselectedIconColor),
                selectedIcon: const Icon(Iconsax.tag_user5, color: UColors.profitGreen),
                label: 'Directory',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.graph, color: unselectedIconColor),
                selectedIcon: const Icon(Iconsax.graph5, color: UColors.profitGreen),
                label: 'Ledger',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const DummyFeedScreen(),
    const PeopleScreen(),
    const LedgerTransactionsScreen(),
  ];
}