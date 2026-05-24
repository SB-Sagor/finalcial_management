import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constraints/u_colors.dart';
import '../controllers/ledger_controller.dart';
import 'widgets/ledger_item_tile.dart';

class LedgerTransactionsScreen extends StatelessWidget {
  const LedgerTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LedgerController());
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('লেনদেন লেজার (Statement)'),
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isLight ? Colors.grey.shade200 : UColors.borderDark,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'মোট জমা (Cash In)',
                        style: TextStyle(
                          fontSize: 12,
                          color: UColors.textSecondaryDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => Text(
                          '৳${controller.totalCashIn.value.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: UColors.profitGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 35,
                  color: isLight ? Colors.grey.shade300 : UColors.borderDark,
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'মোট খরচ (Cash Out)',
                        style: TextStyle(
                          fontSize: 12,
                          color: UColors.textSecondaryDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => Text(
                          '৳${controller.totalCashOut.value.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: UColors.lossRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.allTransactions.isEmpty) {
                return const Center(
                  child: Text(
                    'কোনো লেনদেন রেকর্ড পাওয়া যায়নি।',
                    style: TextStyle(color: UColors.textSecondaryDark),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.allTransactions.length,
                itemBuilder: (context, index) {
                  final tx = controller.allTransactions[index];
                  return ULedgerItemTile(
                    title: tx['title'],
                    category: tx['category'],
                    amount: tx['amount'],
                    method: tx['method'],
                    date: tx['date'],
                    isCashIn: tx['type'] == 'cash_in',
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
