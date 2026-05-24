import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/u_colors.dart';
import '../../../../../utils/constraints/u_sizes.dart';
import '../../../bills/screens/create_invoice_screen.dart';
import '../../../expenses/screens/add_trip_expense_screen.dart';
import '../../../settings/screens/settings_screen.dart';
import '../../../settings/screens/sync_backup_screen.dart';
import 'business_reports_screen.dart';
import 'dues_ledger_screen.dart';
import 'widgets/dashboard_balance_container.dart';
import 'widgets/dashboard_mint_graph.dart';
import 'widgets/quick_action_card.dart';
import 'quick_hub_client_screen.dart';
import 'quick_hub_employee_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BusinessBro',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.cloud_change, color: UColors.accentBlue),
            onPressed: () => Get.to(() => const SyncBackupScreen()),
          ),
          IconButton(
            icon: const Icon(Iconsax.user_edit),
            onPressed: () => Get.to(() => const SettingsScreen()),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Balance Cards
            Row(
              children: [
                Expanded(
                  child: UDashboardBalancedContainer(
                    title: 'total_sales'.tr,
                    amount: '৳ ৪,৫০,০০০',
                    percentageText: '↑ 12%',
                    amountColor: UColors.profitGreen,
                    percentageColor: UColors.profitGreen,
                    indicatorColor: UColors.profitGreen,
                  ),
                ),
                Expanded(
                  child: UDashboardBalancedContainer(
                    title: 'total_due'.tr,
                    amount: '৳ ১,২০,০০০',
                    percentageText: '↓ 5%',
                    amountColor: UColors.accentGold,
                    percentageColor: UColors.accentGold,
                    indicatorColor: UColors.accentGold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: UDashboardBalancedContainer(
                    title: 'net_profit'.tr,
                    amount: '৳ ৮৫,০০০',
                    percentageText: '↑ 8%',
                    amountColor: UColors.accentBlue,
                    percentageColor: UColors.accentBlue,
                    indicatorColor: UColors.accentBlue,
                  ),
                ),
                Expanded(
                  child: UDashboardBalancedContainer(
                    title: 'total_loss'.tr,
                    amount: '৳ ৫,০০০',
                    percentageText: '↓ 2%',
                    amountColor: UColors.lossRed,
                    percentageColor: UColors.lossRed,
                    indicatorColor: UColors.lossRed,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 6.0, bottom: 12.0),
              child: Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: USizes.fontSizeLg,
                  fontWeight: FontWeight.bold,
                  color: isLight
                      ? UColors.textPrimaryLight
                      : UColors.textPrimaryDark,
                ),
              ),
            ),

            // --- Premium Fixed Grid Layout ---
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.95,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                UQuickActionCard(
                  title: 'Create Bill',
                  icon: Iconsax.receipt_2,
                  iconColor: UColors.profitGreen,
                  onTap: () => Get.to(() => const CreateInvoiceScreen()),
                ),
                UQuickActionCard(
                  title: 'Add Expense',
                  icon: Iconsax.card_send,
                  iconColor: UColors.lossRed,
                  onTap: () => Get.to(() => const AddTripExpenseScreen()),
                ),
                UQuickActionCard(
                  title: 'Clients',
                  icon: Iconsax.user_square,
                  iconColor: UColors.accentBlue,
                  onTap: () => Get.to(
                    () => const QuickHubClientScreen(),
                  ), // Redirects to Client Hub Screen
                ),
                UQuickActionCard(
                  title: 'Employees',
                  icon: Iconsax.people,
                  iconColor: UColors.purple,
                  onTap: () => Get.to(
                    () => const QuickHubEmployeeScreen(),
                  ), // Redirects to Employee Hub Screen
                ),
                UQuickActionCard(
                  title: 'Due',
                  icon: Iconsax.document_filter,
                  iconColor: UColors.accentGold,
                  onTap: () => Get.to(() => const DuesLedgerScreen()),
                ),
                UQuickActionCard(
                  title: 'Reports',
                  icon: Iconsax.document_text,
                  iconColor: UColors.accentBlue,
                  onTap: () => Get.to(() => const BusinessReportsScreen()),
                ),
              ],
            ),

            // Premium Reference Analytics Section (Image Standard)
            const UDashboardMintGraph(),
          ],
        ),
      ),
    );
  }
}
