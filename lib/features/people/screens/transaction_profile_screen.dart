import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constraints/u_colors.dart';
import '../../../utils/constraints/u_sizes.dart';
import '../../bills/screens/create_invoice_screen.dart';
import '../controllers/transaction_profile_controller.dart';
import 'widgets/transaction_item_card.dart';

class TransactionProfileScreen extends StatelessWidget {
  const TransactionProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionProfileController());
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final person = controller.personData;
    final isClient = person['type'] == 'client';

    return Scaffold(
      appBar: AppBar(title: Text(person['name'] ?? 'Profile'), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(USizes.cardRadius),
                border: Border.all(
                  color: isLight ? Colors.grey.shade200 : UColors.borderDark,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: isClient
                              ? UColors.accentGold.withOpacity(0.15)
                              : UColors.accentBlue.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          person['initials'] ?? '',
                          style: TextStyle(
                            color: isClient
                                ? UColors.accentGold
                                : UColors.accentBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              person['name'] ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isLight
                                    ? UColors.textPrimaryLight
                                    : UColors.textPrimaryDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              person['sub'] ?? '',
                              style: TextStyle(
                                fontSize: 13,
                                color: UColors.textSecondaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Divider(height: 1, color: UColors.borderDark),
                  ),

                  _buildSummaryRow(
                    'total_billed'.tr,
                    '৳ ২,৪৩,০০০',
                    isLight
                        ? UColors.textPrimaryLight
                        : UColors.textPrimaryDark,
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    'total_paid'.tr,
                    '৳ ১,৯৮,০০০',
                    UColors.profitGreen,
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    'still_due'.tr,
                    '৳ ${person['due']}',
                    UColors.lossRed,
                    isBold: true,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UColors.profitGreen.withOpacity(0.15),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'collect_due_btn'.tr,
                        style: const TextStyle(
                          color: UColors.profitGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLight
                            ? Colors.grey.shade200
                            : UColors.surface3Dark,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.to(
                          () => CreateInvoiceScreen(),
                          arguments: person['name'] ?? ' ',
                        );
                      },
                      child: Text(
                        isClient ? 'new_bill_btn'.tr : 'new_trip_btn'.tr,
                        style: TextStyle(
                          color: isLight
                              ? Colors.black
                              : UColors.textPrimaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 22.0,
                bottom: 10.0,
              ),
              child: Text(
                'history_title'.tr,
                style: TextStyle(
                  fontSize: USizes.fontSizeLg,
                  fontWeight: FontWeight.bold,
                  color: isLight
                      ? UColors.textPrimaryLight
                      : UColors.textPrimaryDark,
                ),
              ),
            ),

            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final tx = controller.transactions[index];
                  return UTransactionItemCard(
                    title: tx['title'],
                    subtitle: tx['subtitle'],
                    amount: tx['amount'],
                    status: tx['status'],
                    details: tx['details'],
                  );
                },
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    Color valueColor, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: UColors.textSecondaryDark,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
