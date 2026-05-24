import 'package:get/get.dart';

class LedgerController extends GetxController {
  static LedgerController get instance => Get.find();

  // লাইভ ক্যাশ-ইন ও ক্যাশ-আউট ট্র্যাকিং
  RxDouble totalCashIn = 0.0.obs;
  RxDouble totalCashOut = 0.0.obs;

  // সম্পূর্ণ ব্যবসার সেন্ট্রাল লেনদেন খতিয়ান ডামি ডাটা (রিয়েলিস্টিক প্রোডাকশন ডেটা)
  RxList<Map<String, dynamic>> allTransactions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadLedgerData();
  }

  void _loadLedgerData() {
    // রিয়েলিস্টিক মিক্সড ট্রানজেকশন ডাটা লোড
    allTransactions.value = [
      {
        'id': 'TXN-001',
        'title': 'ABC Construction',
        'type': 'cash_in', // ইনকাম / কালেকশন
        'category': 'বালু সরবরাহ কালেকশন',
        'amount': 198000.0,
        'method': 'bKash',
        'date': '২০ মে ২০২৬ · ০৪:৩০ PM'
      },
      {
        'id': 'TXN-002',
        'title': 'রহিম মিয়া (ড্রাইভার)',
        'type': 'cash_out', // খরচ
        'category': 'জ্বালানি ও তেল খরচ (ঢাকা-চট্টগ্রাম ট্রিপ)',
        'amount': 14500.0,
        'method': 'Cash',
        'date': '১৯ মে ২০২৬ · ১১:১৫ AM'
      },
      {
        'id': 'TXN-003',
        'title': 'মেসার্স সততা ট্রেডার্স',
        'type': 'cash_in',
        'category': 'অগ্রিম বুকিং পেমেন্ট',
        'amount': 50000.0,
        'method': 'Bank',
        'date': '১৮ মে ২০২৬ · ১০:০০ AM'
      },
      {
        'id': 'TXN-004',
        'title': 'মেঘনা ঘাট টোল প্লাজা',
        'type': 'cash_out',
        'category': 'ট্রাক #০৩ টোল বিল',
        'amount': 1200.0,
        'method': 'Cash',
        'date': '১৭ মে ২০২৬ · ০২:৪৫ AM'
      },
    ];

    _calculateSummary();
  }

  void _calculateSummary() {
    double incoming = 0.0;
    double outgoing = 0.0;

    for (var tx in allTransactions) {
      if (tx['type'] == 'cash_in') {
        incoming += tx['amount'];
      } else {
        outgoing += tx['amount'];
      }
    }

    totalCashIn.value = incoming;
    totalCashOut.value = outgoing;
  }
}