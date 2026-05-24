import 'package:flutter/material.dart';
import '../../../../../../utils/constraints/u_colors.dart';

class ULedgerItemTile extends StatelessWidget {
  const ULedgerItemTile({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.method,
    required this.date,
    required this.isCashIn,
  });

  final String title;
  final String category;
  final double amount;
  final String method;
  final String date;
  final bool isCashIn;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isLight ? Colors.grey.shade50 : UColors.borderDark),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isCashIn ? UColors.profitGreen.withOpacity(0.08) : UColors.lossRed.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCashIn ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
              color: isCashIn ? UColors.profitGreen : UColors.lossRed,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isLight ? Colors.black : UColors.textPrimaryDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(category, style: const TextStyle(fontSize: 12, color: UColors.textSecondaryDark)),
                const SizedBox(height: 4),
                Text(date, style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isCashIn ? "+" : "-"} ৳${amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isCashIn ? UColors.profitGreen : UColors.lossRed,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isLight ? Colors.grey.shade100 : UColors.surface3Dark,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  method,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: method == 'bKash' ? Colors.pink : (isLight ? Colors.black87 : UColors.textPrimaryDark),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}