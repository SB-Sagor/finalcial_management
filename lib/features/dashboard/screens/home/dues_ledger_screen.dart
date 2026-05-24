import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/u_colors.dart';

class DuesLedgerScreen extends StatelessWidget {
  const DuesLedgerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    // Real-world Customer Dues Data
    final List<Map<String, dynamic>> duesList = [
      {
        'name': 'M/S Sata Traders',
        'project': 'মিরপুর সাইট পাথর সাপ্লাই',
        'dueAmount': '৳১,২০,০০০',
        'days': '১২ দিন বাকি',
        'isUrgent': true,
      },
      {
        'name': 'ABC Construction',
        'project': 'উত্তরা প্রজেক্ট বালু',
        'dueAmount': '৳৪৫,০০০',
        'days': '৫ দিন বাকি',
        'isUrgent': false,
      },
      {
        'name': 'Ahsan Enterprise',
        'project': 'সাভার রড ডেলিভারি',
        'dueAmount': '৳৮,৫০০',
        'days': 'আজ লাস্ট ডেট',
        'isUrgent': true,
      },
      {
        'name': 'জহিরুল ইসলাম (ঠিকাদার)',
        'project': 'ইট ও সিমেন্ট',
        'dueAmount': '৳৬,২০০',
        'days': '২০ দিন অতিবাহিত',
        'isUrgent': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'বকেয়া খাতা (Dues Book)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: UColors.accentGold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: UColors.accentGold.withValues(alpha: 0.3),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'বাজারে সর্বমোট বকেয়া পাওনা',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '৳১,৭৯,৭০০',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: UColors.accentGold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'বকেয়া কাস্টমারদের তালিকা',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: duesList.length,
                itemBuilder: (context, index) {
                  final customer = duesList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isLight
                            ? Colors.grey.shade200
                            : const Color(0xFF222431),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      customer['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (customer['isUrgent'])
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: const Text(
                                          'তাগিদ দিন',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  customer['project'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  customer['dueAmount'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: UColors.lossRed,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  customer['days'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: customer['isUrgent']
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  side: BorderSide(color: Colors.grey.shade400),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Iconsax.call,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                label: const Text(
                                  'কল দিন',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:  Colors.green.shade800,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Iconsax.message,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'WhatsApp তাগিদ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
