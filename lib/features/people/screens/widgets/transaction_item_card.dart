import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constraints/u_colors.dart';
import '../../../../utils/constraints/u_sizes.dart';

class UTransactionItemCard extends StatelessWidget {
  const UTransactionItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
    required this.details,
  });

  final String title;
  final String subtitle;
  final int amount;
  final String status; // 'billed' or 'paid'
  final String details;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final isPaid = status == 'paid';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      padding: const EdgeInsets.all(USizes.cardPadding),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(USizes.cardRadius - 2),
        border: Border.all(
          color: isLight ? Colors.grey.shade200 : UColors.borderDark,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: USizes.fontSizeMd,
                        fontWeight: FontWeight.w600,
                        color: isLight ? UColors.textPrimaryLight : UColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: USizes.fontSizeSm, color: UColors.textSecondaryDark),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isPaid ? "+" : "-"} ৳$amount',
                    style: TextStyle(
                      fontSize: USizes.fontSizeMd + 1,
                      fontWeight: FontWeight.bold,
                      color: isPaid ? UColors.profitGreen : UColors.lossRed,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isPaid ? UColors.profitGreen.withOpacity(0.1) : UColors.accentGold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isPaid ? 'clear_badge'.tr : 'due_badge'.tr,
                      style: TextStyle(
                        color: isPaid ? UColors.profitGreen : UColors.accentGold,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(height: 1, color: UColors.borderDark),
          ),
          Text(
            details,
            style: TextStyle(fontSize: USizes.fontSizeSm, color: UColors.textSecondaryDark, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}