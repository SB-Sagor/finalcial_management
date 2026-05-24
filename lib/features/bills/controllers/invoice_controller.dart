import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  static InvoiceController get instance => Get.find();

  // form controller
  final clientNameController = TextEditingController();
  final itemNameController = TextEditingController();
  final rateController = TextEditingController();
  final quantityController = TextEditingController();
  final paidAmountController = TextEditingController();

  // real time
  RxDouble subTotal = 0.0.obs;
  RxDouble paidAmount = 0.0.obs;
  RxDouble remainingDue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    //auto calculate rate
    rateController.addListener(_calculateTotal);
    quantityController.addListener(_calculateTotal);
    paidAmountController.addListener(_calculateTotal);
  }

  void _calculateTotal() {
    double rate = double.tryParse(rateController.text) ?? 0.0;
    double qty = double.tryParse(quantityController.text) ?? 0.0;
    double paid = double.tryParse(paidAmountController.text) ?? 0.0;

    subTotal.value = rate * qty;
    paidAmount.value = paid;
    remainingDue.value = subTotal.value - paidAmount.value;
  }

  void resetForm() {
    clientNameController.clear();
    itemNameController.clear();
    rateController.clear();
    quantityController.clear();
    paidAmountController.clear();
    subTotal.value = 0.0;
    paidAmount.value = 0.0;
    remainingDue.value = 0.0;
  }

  @override
  void onClose() {
    clientNameController.dispose();
    itemNameController.dispose();
    rateController.dispose();
    quantityController.dispose();
    paidAmountController.dispose();
    super.onClose();
  }
}