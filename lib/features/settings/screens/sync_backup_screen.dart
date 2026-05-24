import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constraints/u_colors.dart';
import '../controllers/sync_backup_controller.dart';

class SyncBackupScreen extends StatelessWidget {
  const SyncBackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SyncBackupController());
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ডেটা ব্যাকআপ ও সিঙ্ক'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- লাইভ স্ট্যাটাস কার্ড პ্যানেল ---
            Obx(() {
              Color statusColor = UColors.profitGreen;
              IconData statusIcon = Iconsax.cloud_add;
              String statusText = 'আপনার সমস্ত ডেটা ক্লাউডে সুরক্ষিত আছে';

              if (controller.syncStatus.value == 'offline') {
                statusColor = UColors.accentGold;
                statusIcon = Iconsax.cloud_notif;
                statusText = 'অফলাইন মোড: লেনদেন ফোনে সংরক্ষিত হচ্ছে';
              } else if (controller.syncStatus.value == 'syncing') {
                statusColor = UColors.accentBlue;
                statusIcon = Iconsax.cloud_lightning;
                statusText = 'ক্লাউড সার্ভারের সাথে সিঙ্ক হচ্ছে...';
              }

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.3), width: 1.2),
                ),
                child: Row(
                  children: [
                    controller.syncStatus.value == 'syncing'
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2, color: UColors.accentBlue),
                    )
                        : Icon(statusIcon, color: statusColor, size: 24),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.syncStatus.value == 'synced'
                                ? 'সুরক্ষিত (Synced)'
                                : (controller.syncStatus.value == 'offline' ? 'অফলাইন ব্যাকআপ' : 'সিঙ্ক চলছে'),
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: statusColor),
                          ),
                          const SizedBox(height: 3),
                          Text(statusText, style: TextStyle(fontSize: 12, color: isLight ? Colors.black87 : Colors.grey.shade400)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),

            // --- ব্যাকআপ ডিটেইলস কার্ড ---
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isLight ? Colors.grey.shade200 : UColors.borderDark),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('সর্বশেষ ক্লাউড ব্যাকআপ', style: TextStyle(fontSize: 12, color: UColors.textSecondaryDark)),
                      Obx(() => Text(controller.lastBackupTime.value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Divider(height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('পেন্ডিং অফলাইন ডেটা', style: TextStyle(fontSize: 13, color: UColors.textSecondaryDark)),
                      Obx(() => Text('${controller.pendingOfflineTransactions.value} টি লেনদেন', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // --- অ্যাকশন বাটন প্যানেল ---
            // --- অ্যাকশন বাটন প্যানেল (FIXED FOR OVERFLOW) ---
            Row(
              children: [
                // অফলাইন মোড টেস্ট করার বাটন
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4), // প্যাডিং কিছুটা কমানো হলো
                      side: BorderSide(color: isLight ? Colors.grey.shade400 : UColors.borderDark),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => controller.simulateOfflineMode(),
                    child: const Text(
                      'সিমুলেট অফলাইন',
                      maxLines: 1, // লেখা এক লাইনে সীমাবদ্ধ থাকবে
                      overflow: TextOverflow.ellipsis, // বেশি বড় হলে ... দেখাবে, কিন্তু স্ক্রিন ভাঙবে না
                      style: TextStyle(color: UColors.textSecondaryDark, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // স্পেসিং ১২ থেকে কমিয়ে ১০ করা হলো

                // এখন সিঙ্ক করুন বাটন
                Expanded(
                  child: Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.syncStatus.value == 'syncing' ? Colors.grey : UColors.profitGreen,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4), // প্যাডিং কমানো হলো
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => controller.triggerCloudSync(),
                    child: Text(
                      controller.syncStatus.value == 'syncing' ? 'সিঙ্ক হচ্ছে...' : 'এখনই সিঙ্ক করুন',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13), // সাইজ ১৪ থেকে ১৩ করা হলো
                    ),
                  )),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}