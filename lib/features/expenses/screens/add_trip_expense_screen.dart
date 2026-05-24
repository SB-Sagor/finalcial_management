import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constraints/u_colors.dart';
import '../../bills/screens/widgets/invoice_text_field.dart'; // আগের মডিউলের টেক্সটফিল্ড উইজেট রিইউজ করা হয়েছে
import '../controllers/trip_expense_controller.dart';
import 'widgets/payment_method_selector.dart';

class AddTripExpenseScreen extends StatelessWidget {
  const AddTripExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TripExpenseController());
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: Text('new_trip_btn'.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // গাড়ির নাম্বার ইনপুট
                    UInvoiceTextField(
                      label: 'গাড়ির নাম্বার (Vehicle No.)',
                      hint: 'যেমন: ঢাকা মেট্রো-ট ১১-১২৩৪',
                      controller: controller.vehicleNumberController,
                      prefixIcon: Iconsax.truck,
                    ),
                    const SizedBox(height: 16),

                    // ড্রাইভারের নাম
                    UInvoiceTextField(
                      label: 'ড্রাইভারের নাম',
                      hint: 'যেমন: রহিম মিয়া',
                      controller: controller.driverNameController,
                      prefixIcon: Iconsax.user,
                    ),
                    const SizedBox(height: 16),

                    // ৩টি খরচের ক্যাটাগরি (তেল, টোল, অন্যান্য)
                    UInvoiceTextField(
                      label: 'জ্বালানি/তেল খরচ',
                      hint: '৳ ০.০০',
                      controller: controller.fuelExpenseController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Iconsax.gas_station,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: UInvoiceTextField(
                            label: 'টোল খরচ',
                            hint: '৳ ০.০০',
                            controller: controller.tollExpenseController,
                            keyboardType: TextInputType.number,
                            prefixIcon: Iconsax.ticket,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: UInvoiceTextField(
                            label: 'অন্যান্য খরচ',
                            hint: '৳ ০.০০',
                            controller: controller.otherExpenseController,
                            keyboardType: TextInputType.number,
                            prefixIcon: Iconsax.computing,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // কাস্টম পেমেন্ট মেথড সিলেক্টর
                    Obx(() => UPaymentMethodSelector(
                      selectedMethod: controller.selectedPaymentMethod.value,
                      onMethodSelected: (method) => controller.updatePaymentMethod(method),
                    )),
                  ],
                ),
              ),
            ),

            // --- মোট খরচ ও কনফার্মেশন বটম প্যানেল ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
                border: Border(top: BorderSide(color: isLight ? Colors.grey.shade200 : UColors.borderDark)),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('মোট খরচ (Total Expense):', style: TextStyle(color: UColors.textSecondaryDark, fontSize: 14)),
                        Obx(() => Text('৳ ${controller.totalTripExpense.value.toStringAsFixed(2)}',
                            style: const TextStyle(color: UColors.lossRed, fontSize: 16, fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // সাবমিট বাটন
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UColors.lossRed, // খরচের জন্য ব্র্যান্ড রেড থিম
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.snackbar(
                            'রেকর্ড করা হয়েছে',
                            'ট্রিপের খরচ সফলভাবে হিসাব খাতায় যুক্ত হয়েছে',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: UColors.lossRed,
                            colorText: Colors.white,
                          );
                        },
                        child: const Text('খরচ নিশ্চিত করুন', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}