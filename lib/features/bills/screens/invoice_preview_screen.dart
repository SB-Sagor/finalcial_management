import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constraints/u_colors.dart';
import '../controllers/invoice_controller.dart';

class InvoicePreviewScreen extends StatelessWidget {
  const InvoicePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InvoiceController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Preview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<Uint8List>(
        future: controller.generatePdfData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error generating preview'));
          }

          final pdfData = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: PdfPreview(
                  build: (format) => pdfData,
                  allowPrinting: false,
                  allowSharing: false,
                  canChangePageFormat: false,
                  canChangeOrientation: false,
                  dynamicLayout: false,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: UColors.profitGreen),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () async {
                            await Printing.layoutPdf(
                              onLayout: (format) async => pdfData,
                            );
                          },
                          icon: const Icon(Iconsax.printer, color: UColors.profitGreen, size: 20),
                          label: const Text('Print Invoice', style: TextStyle(color: UColors.profitGreen, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: UColors.profitGreen,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () async {
                            await Printing.sharePdf(
                              bytes: pdfData,
                              filename: 'invoice_${DateTime.now().millisecondsSinceEpoch}.pdf',
                            );
                          },
                          icon: const Icon(Iconsax.share, color: Colors.white, size: 20),
                          label: const Text('Share PDF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}