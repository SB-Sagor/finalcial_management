import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constraints/u_colors.dart';
import '../controllers/invoice_controller.dart';
import 'invoice_preview_screen.dart';
import 'widgets/invoice_text_field.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  final controller = Get.put(InvoiceController());
  bool _isCftCalculatorMode = true;

  // final _lenFtFocus = FocusNode();
  // final _lenInFocus = FocusNode();
  // final _widFtFocus = FocusNode();
  // final _widInFocus = FocusNode();
  // final _hgtFtFocus = FocusNode();
  // final _hgtInFocus = FocusNode();
  // final _rate = FocusNode();
  // final _truck = FocusNode();

  final _lenFtController = TextEditingController();
  final _lenInController = TextEditingController();
  final _widFtController = TextEditingController();
  final _widInController = TextEditingController();
  final _hgtFtController = TextEditingController();
  final _hgtInController = TextEditingController();

  void _calculateCft() {
    double lenFt = double.tryParse(_lenFtController.text.trim()) ?? 0;
    double lenIn = double.tryParse(_lenInController.text.trim()) ?? 0;
    double widFt = double.tryParse(_widFtController.text.trim()) ?? 0;
    double widIn = double.tryParse(_widInController.text.trim()) ?? 0;
    double hgtFt = double.tryParse(_hgtFtController.text.trim()) ?? 0;
    double hgtIn = double.tryParse(_hgtInController.text.trim()) ?? 0;

    double totalLength = lenFt + (lenIn / 12);
    double totalWidth = widFt + (widIn / 12);
    double totalHeight = hgtFt + (hgtIn / 12);

    double calculatedCft = totalLength * totalWidth * totalHeight;

    if (calculatedCft > 0) {
      controller.quantityController.text = calculatedCft.toStringAsFixed(2);
      controller.updateCftDetails(
        lFt: lenFt,
        lIn: lenIn,
        wFt: widFt,
        wIn: widIn,
        hFt: hgtFt,
        hIn: hgtIn,
      );
      controller.calculateInvoice();
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _lenFtController.dispose();
    _lenInController.dispose();
    _widFtController.dispose();
    _widInController.dispose();
    _hgtFtController.dispose();
    _hgtInController.dispose();

    // Dispose focus nodes
    // _lenFtFocus.dispose();
    // _lenInFocus.dispose();
    // _widFtFocus.dispose();
    // _widInFocus.dispose();
    // _hgtFtFocus.dispose();
    // _hgtInFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'CFT মাপার ক্যালকুলেটর ব্যবহার করবেন?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: _isCftCalculatorMode,
                          activeColor: UColors.profitGreen,
                          onChanged: (value) {
                            setState(() {
                              _isCftCalculatorMode = value;
                              if (!value) controller.cftMeasurementDetails = '';
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (_isCftCalculatorMode) ...[
                      Row(
                        children: [
                          Expanded(
                            child: UInvoiceTextField(
                              label: 'দৈর্ঘ্য (ফুট)',
                              hint: '০',
                              controller: _lenFtController,
                              // focusNode: _lenFtFocus,
                              keyboardType: TextInputType.number,
                              prefixIcon: Iconsax.ruler,
                              // onSubmitted: (_) => FocusScope.of(
                              //   context,
                              // ).requestFocus(_lenInFocus),
                              onChanged: (value) {
                                // if (value.isNotEmpty) {
                                //   FocusScope.of(
                                //     context,
                                //   ).requestFocus(_lenInFocus);
                                // }
                                _calculateCft();
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: UInvoiceTextField(
                              label: 'দৈর্ঘ্য (ইঞ্চি)',
                              hint: '০',
                              controller: _lenInController,
                              // focusNode: _lenInFocus,
                              keyboardType: TextInputType.number,
                              prefixIcon: Iconsax.ruler,
                              // onSubmitted: (_) => FocusScope.of(
                              //   context,
                              // ).requestFocus(_widFtFocus),
                              onChanged: (value) {
                                // if (value.isNotEmpty) {
                                //   FocusScope.of(
                                //     context,
                                //   ).requestFocus(_widFtFocus);
                                // }
                                _calculateCft();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: UInvoiceTextField(
                              label: 'প্রস্থ (ফুট)',
                              hint: '০',
                              controller: _widFtController,
                              // focusNode: _widFtFocus,
                              keyboardType: TextInputType.number,
                              prefixIcon: Iconsax.ruler,
                              onChanged: (value) {
                                // if (value.isNotEmpty) {
                                //   FocusScope.of(
                                //     context,
                                //   ).requestFocus(_widInFocus);
                                // }
                                _calculateCft();
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: UInvoiceTextField(
                              label: 'প্রস্থ (ইঞ্চি)',
                              hint: '০',
                              controller: _widInController,
                              // focusNode: _widInFocus,
                              keyboardType: TextInputType.number,
                              prefixIcon: Iconsax.ruler,
                              onChanged: (value) {
                                // if (value.isNotEmpty) {
                                //   FocusScope.of(
                                //     context,
                                //   ).requestFocus(_hgtFtFocus);
                                // }
                                _calculateCft();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: UInvoiceTextField(
                              label: 'উচ্চতা (ফুট)',
                              hint: '০',
                              controller: _hgtFtController,
                              // focusNode: _hgtFtFocus,
                              keyboardType: TextInputType.number,
                              prefixIcon: Iconsax.ruler,
                              onChanged: (value) {
                                // if (value.isNotEmpty) {
                                //   FocusScope.of(
                                //     context,
                                //   ).requestFocus(_hgtInFocus);
                                // }
                                _calculateCft();
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: UInvoiceTextField(
                              label: 'উচ্চতা (ইঞ্চি)',
                              hint: '০',
                              controller: _hgtInController,
                              // focusNode: _hgtInFocus,
                              keyboardType: TextInputType.number,
                              prefixIcon: Iconsax.ruler,
                              onChanged: (value) {
                                // if (value.isNotEmpty) {
                                //   FocusScope.of(context).requestFocus(_rate);
                                // }
                                _calculateCft();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],

                    Row(
                      children: [
                        Expanded(
                          child: UInvoiceTextField(
                            label: 'rate_label'.tr,
                            hint: '৳ ০.০০',
                            controller: controller.rateController,
                            // focusNode: _rate,
                            keyboardType: TextInputType.number,
                            prefixIcon: Iconsax.money_3,
                            onChanged: (_) => _calculateCft(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: UInvoiceTextField(
                            label: 'পরিমাণ (Qty / CFT)',
                            hint: '০.০০',
                            controller: controller.quantityController,
                            keyboardType: TextInputType.number,
                            prefixIcon: Iconsax.box,
                            readOnly: _isCftCalculatorMode,
                            onChanged: (_) => controller.calculateInvoice(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: UInvoiceTextField(
                            label: 'ট্রাক সংখ্যা (Count)',
                            hint: '',
                            controller: controller.truckCountController,
                            // focusNode: _truck,
                            keyboardType: TextInputType.number,
                            prefixIcon: Iconsax.truck,
                            onChanged: (_) => controller.calculateInvoice(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: UInvoiceTextField(
                            label: 'গাড়ি ভাড়া (Per Fare)',
                            hint: '৳ ০.০০',
                            controller: controller.perTruckFareController,
                            keyboardType: TextInputType.number,
                            prefixIcon: Iconsax.truck_fast,
                            onChanged: (_) => controller.calculateInvoice(),
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
                      onChanged: (_) => controller.calculateInvoice(),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                border: Border(
                  top: BorderSide(
                    color: isLight ? Colors.grey.shade200 : UColors.borderDark,
                  ),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'মোট বিল (Subtotal):',
                          style: TextStyle(
                            color: UColors.textSecondaryDark,
                            fontSize: 14,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '৳ ${controller.subTotal.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: isLight
                                  ? Colors.black
                                  : UColors.textPrimaryDark,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'still_due'.tr + ':',
                          style: const TextStyle(
                            color: UColors.textSecondaryDark,
                            fontSize: 14,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '৳ ${controller.remainingDue.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: controller.remainingDue.value > 0
                                  ? UColors.lossRed
                                  : UColors.profitGreen,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UColors.profitGreen,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => const InvoicePreviewScreen());
                        },
                        child: const Text(
                          'ইনভয়েস নিশ্চিত করুন',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
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
