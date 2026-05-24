import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripExpenseController extends GetxController {
  static TripExpenseController get instance => Get.find();

  // ফর্ম টেক্সট এডিটিং কন্ট্রোলার
  final vehicleNumberController = TextEditingController();
  final driverNameController = TextEditingController();
  final fuelExpenseController = TextEditingController();
  final tollExpenseController = TextEditingController();
  final otherExpenseController = TextEditingController();

  // পেমেন্ট মোড সিলেকশন (ক্যাশ, বিকাশ, ব্যাংক ইত্যাদি)
  RxString selectedPaymentMethod = 'Cash'.obs;

  // লাইভ মোট খরচ ক্যালকুলেশন ভেরিয়েবল
  RxDouble totalTripExpense = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // যেকোনো খরচের ফিল্ড চেঞ্জ হলে স্বয়ংক্রিয়ভাবে মোট খরচ আপডেট করার লিসেনার
    fuelExpenseController.addListener(_calculateTotalExpense);
    tollExpenseController.addListener(_calculateTotalExpense);
    otherExpenseController.addListener(_calculateTotalExpense);
  }

  void _calculateTotalExpense() {
    double fuel = double.tryParse(fuelExpenseController.text) ?? 0.0;
    double toll = double.tryParse(tollExpenseController.text) ?? 0.0;
    double other = double.tryParse(otherExpenseController.text) ?? 0.0;

    totalTripExpense.value = fuel + toll + other;
  }

  void updatePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void clearForm() {
    vehicleNumberController.clear();
    driverNameController.clear();
    fuelExpenseController.clear();
    tollExpenseController.clear();
    otherExpenseController.clear();
    selectedPaymentMethod.value = 'Cash';
    totalTripExpense.value = 0.0;
  }

  @override
  void onClose() {
    vehicleNumberController.dispose();
    driverNameController.dispose();
    fuelExpenseController.dispose();
    tollExpenseController.dispose();
    otherExpenseController.dispose();
    super.onClose();
  }
}