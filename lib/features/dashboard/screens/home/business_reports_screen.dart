import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/u_colors.dart';

class BusinessReportsScreen extends StatelessWidget {
  const BusinessReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('রিপোর্ট ও স্টেটমেন্ট', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Financial Summary Reports', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 12),

            // Report Option 1: Full Ledger PDF
            _buildReportCard(
              context: context,
              title: 'সম্পূর্ণ লেজার রিপোর্ট (PDF)',
              subtitle: 'সব কাস্টমার ও কর্মচারীর টোটাল হিসাবের খাতা।',
              icon: Iconsax.document_text5,
              iconColor: UColors.accentBlue,
              isLight: isLight,
            ),

            // Report Option 2: Sales & Profit Sheet
            _buildReportCard(
              context: context,
              title: 'মাসিক লাভ-ক্ষতি স্টেটমেন্ট',
              subtitle: 'নির্দিষ্ট মাসের মোট লাভ, লস এবং খরচ বিশ্লেষণ।',
              icon: Iconsax.status_up5,
              iconColor: UColors.profitGreen,
              isLight: isLight,
            ),

            // Report Option 3: Dues List
            _buildReportCard(
              context: context,
              title: 'বকেয়া খাতার রিপোর্ট (Due List)',
              subtitle: 'কার কার কাছে কত টাকা বাকি আছে তার ফুল পিডিএফ।',
              icon: Iconsax.document_filter5,
              iconColor: UColors.accentGold,
              isLight: isLight,
            ),

            const Spacer(),

            // Share Action Bottom Sheet / Indicator Preview Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isLight ? Colors.grey.shade50 : const Color(0xFF121318),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isLight ? Colors.grey.shade200 : const Color(0xFF1F212A)),
              ),
              child: Row(
                children: [
                  const Icon(Iconsax.info_circle5, color: UColors.accentBlue, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'যেকোনো রিপোর্ট জেনারেট করে সরাসরি কাস্টমারের WhatsApp-এ চালান হিসেবে শেয়ার করতে পারবেন।',
                      style: TextStyle(fontSize: 12, color: isLight ? Colors.black54 : Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required bool isLight,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isLight ? Colors.grey.shade200 : const Color(0xFF222431)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.1),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLight ? Colors.grey.shade100 : const Color(0xFF1C1D24),
            shape: BoxShape.circle,
          ),
          child: const Icon(Iconsax.export_1, size: 16, color: Colors.grey),
        ),
        onTap: () {
          // Future: Trigger PDF Generator service
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title জেনারেট হচ্ছে...'), backgroundColor: UColors.profitGreen),
          );
        },
      ),
    );
  }
}