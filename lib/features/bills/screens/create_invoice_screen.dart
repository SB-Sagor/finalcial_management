import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constraints/u_colors.dart';
import '../controllers/invoice_controller.dart';
import 'widgets/invoice_text_field.dart';

class CreateInvoiceScreen extends StatelessWidget {
  const CreateInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceController());
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: Text('new_bill_btn'.tr),
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
                    UInvoiceTextField(
                      label: 'tab_clients'.tr,
                      hint: 'যেমন: ABC Construction',
                      controller: controller.clientNameController,
                      prefixIcon: Iconsax.user,
                    ),
                    const SizedBox(height: 16),

                    UInvoiceTextField(
                      label: 'বিবরণ (Description)',
                      hint: 'যেমন: সিলেট ভিটি বালু সরবরাহ',
                      controller: controller.itemNameController,
                      prefixIcon: Iconsax.document_text,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: UInvoiceTextField(
                            label: 'rate_label'.tr,
                            hint: '৳ ০.০০',
                            controller: controller.rateController,
                            keyboardType: TextInputType.number,
                            prefixIcon: Iconsax.money_3,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: UInvoiceTextField(
                            label: 'পরিমাণ (Qty)',
                            hint: 'যেমন: ৩ ট্রাক / cft',
                            controller: controller.quantityController,
                            keyboardType: TextInputType.number,
                            prefixIcon: Iconsax.box,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),


                    UInvoiceTextField(
                      label: 'টাকা জমা (Paid Amount)',
                      hint: '৳ ০.০০',
                      controller: controller.paidAmountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: Iconsax.wallet_check,
                    ),
                  ],
                ),
              ),
            ),

            // real time bottom bar
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
                    // total bill
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('মোট বিল (Subtotal):', style: TextStyle(color: UColors.textSecondaryDark, fontSize: 14)),
                        Obx(() => Text('৳ ${controller.subTotal.value.toStringAsFixed(2)}',
                            style: TextStyle(color: isLight ? Colors.black : UColors.textPrimaryDark, fontSize: 15, fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // due
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('still_due'.tr + ':', style: const TextStyle(color: UColors.textSecondaryDark, fontSize: 14)),
                        Obx(() => Text('৳ ${controller.remainingDue.value.toStringAsFixed(2)}',
                            style: TextStyle(color: controller.remainingDue.value > 0 ? UColors.lossRed : UColors.profitGreen, fontSize: 15, fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // invoice button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UColors.profitGreen,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          // future database will be store here
                          Get.back();
                          Get.snackbar(
                            'সফল হয়েছে',
                            'নতুন ইনভয়েস সফলভাবে রেকর্ড করা হয়েছে',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: UColors.profitGreen,
                            colorText: Colors.white,
                          );
                        },
                        child: const Text('ইনভয়েস নিশ্চিত করুন', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
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