import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      // Dashboard
      'dashboard_title': 'Dashboard',
      'total_sales': 'Total Sales',
      'total_due': 'Total Due',
      'net_profit': 'Net Profit',
      'total_loss': 'Total Loss',
      'up_month': 'this month',
      'down_week': 'vs last week',
      'growth': 'growth',
      'loss_text': 'vs last month',

      // People Management (Clean & Realistic)
      'people_title': 'Directory',
      'tab_all': 'Overview',
      'tab_clients': 'Clients',
      'tab_employees': 'Staff',
      'filter_all': 'All Accounts',
      'filter_due': 'Receivables',
      'filter_clear': 'Settled',
      'filter_new': 'Recent Entries',
      'due_badge': 'OUTSTANDING',
      'clear_badge': 'PAID',
      'no_data': 'No matching records found.',

      // Profile & Transactions
      'total_billed': 'Gross Invoiced',
      'total_paid': 'Total Collected',
      'still_due': 'Net Outstanding',
      'collect_due_btn': 'Receive Payment',
      'new_bill_btn': 'Create Invoice',
      'new_trip_btn': 'Log New Trip',
      'history_title': 'Ledger History',
    },
    'bn': {
      // ড্যাশবোর্ড
      'dashboard_title': 'ড্যাশবোর্ড',
      'total_sales': 'মোট বেচাকেনা',
      'total_due': 'মোট বাকি',
      'net_profit': 'খাঁটি লাভ',
      'total_loss': 'মোট লোকসান',
      'up_month': 'এই মাসে',
      'down_week': 'গত সপ্তাহের তুলনায়',
      'growth': 'প্রবৃদ্ধি',
      'loss_text': 'গত মাসের তুলনায়',

      // পিপল ম্যানেজমেন্ট (রিয়েলিস্টিক বাংলা)
      'people_title': 'হিসাব খাতা',
      'tab_all': 'সারসংক্ষেপ',
      'tab_clients': 'গ্রাহক তালিকা',
      'tab_employees': 'স্টাফ ও কর্মী',
      'filter_all': 'সব হিসাব',
      'filter_due': 'বাকি খাতা',
      'filter_clear': 'পরিশোধিত',
      'filter_new': 'নতুন যুক্ত',
      'due_badge': 'বকেয়া',
      'clear_badge': 'পরিশোধ',
      'no_data': 'কোনো তথ্য মেলেনি।',

      // প্রোফাইল ও লেনদেন
      'total_billed': 'মোট বিল',
      'total_paid': 'মোট আদায়',
      'still_due': 'চলতি বকেয়া',
      'collect_due_btn': 'টাকা আদায়',
      'new_bill_btn': 'নতুন ইনভয়েস',
      'new_trip_btn': 'নতুন ট্রিপ এন্ট্রি',
      'history_title': 'লেনদেন লেজার',
    }
  };
}