import 'package:get/get.dart';

class SyncBackupController extends GetxController {
  static SyncBackupController get instance => Get.find();

  // সিঙ্ক স্ট্যাটাস স্টেট: 'synced' (সব ঠিক আছে), 'offline' (অফলাইন মোড), 'syncing' (আপলোড হচ্ছে)
  RxString syncStatus = 'synced'.obs;

  // সর্বশেষ ব্যাকআপ নেওয়ার সময়
  RxString lastBackupTime = 'আজ, দুপুর ১২:১৫ PM'.obs;

  // অফলাইনে জমা থাকা পেন্ডিং ট্রানজেকশনের সংখ্যা
  RxInt pendingOfflineTransactions = 0.obs;

  // রিয়েলিস্টিক সিঙ্ক ট্রিগার ফাংশন (Simulated Server Sync)
  void triggerCloudSync() async {
    if (syncStatus.value == 'syncing') return;

    // সিঙ্কিং অ্যানিমেশন স্টেট চালু
    syncStatus.value = 'syncing';

    // রিয়েলিস্টিক সার্ভার রেসপন্স ডিলে (৩ সেকেন্ড ওয়েট)
    await Future.delayed(const Duration(seconds: 3));

    // সিঙ্ক সফল হওয়ার পর স্টেট আপডেট
    pendingOfflineTransactions.value = 0;
    syncStatus.value = 'synced';
    lastBackupTime.value = 'এইমাত্র (সফলভাবে ক্লাউডে সংরক্ষিত)';
  }

  // ডামি ফাংশন: নেটওয়ার্ক চলে গেলে অফলাইন মোড সিমুলেট করার জন্য
  void simulateOfflineMode() {
    syncStatus.value = 'offline';
    pendingOfflineTransactions.value = 3; // ৩টি লেনদেন ফোনে অফলাইন জমা আছে
  }
}