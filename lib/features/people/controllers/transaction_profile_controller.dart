import 'package:get/get.dart';

class TransactionProfileController extends GetxController {
  // ডাইনামিক্যালি সিলেক্টেড পারসনের ডেটা হোল্ড করার ভেরিয়েবল
  final RxMap<String, dynamic> personData = <String, dynamic>{}.obs;
  final RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[].obs;

  void loadProfile(Map<String, dynamic> person) {
    personData.value = person;

    // HTML ফাইল অনুযায়ী ডামি ট্রানজেকশন হিস্টোরি লোড করা হচ্ছে
    if (person['type'] == 'client') {
      transactions.value = [
        {
          'title': 'বালু সরবরাহ — সিলেট ভিটি',
          'subtitle': '৩ ট্রাক × ২৫০ cft · ২ মে ২০২৬',
          'amount': 243000,
          'status': 'billed',
          'details': 'গাড়ি ভাড়া: ৳১২,০০০/ট্রাক'
        },
        {
          'title': 'অগ্রিম পেমেন্ট জমা',
          'subtitle': 'bKash মার্চেন্ট অ্যাকাউন্ট · ১৫ এপ্রিল ২০২৬',
          'amount': 198000,
          'status': 'paid',
          'details': 'ট্রানজেকশন আইডি: TxN98432'
        }
      ];
    } else {
      transactions.value = [
        {
          'title': 'ঢাকা-চট্টগ্রাম ট্রিপ #৪৫',
          'subtitle': 'মেসার্স সততা ট্রেডার্স মাল লোড · ১০ মে ২০২৬',
          'amount': 28000,
          'status': 'billed',
          'details': 'ভাড়া: ৳৪,০০০/গাড়ি · পেমেন্ট: bKash'
        },
        {
          'title': 'বেতন ও খোরাকি বিতরণ',
          'subtitle': 'ক্যাশ পেমেন্ট · ৩০ এপ্রিল ২০২৬',
          'amount': 20000,
          'status': 'paid',
          'details': 'হাতে হাতে পরিশোধ'
        }
      ];
    }
  }
}