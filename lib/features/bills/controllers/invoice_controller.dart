import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceController extends GetxController {
  final clientNameController = TextEditingController();
  final itemNameController = TextEditingController();
  final rateController = TextEditingController();
  final quantityController = TextEditingController();
  final paidAmountController = TextEditingController();

  final truckCountController = TextEditingController(text: '1');
  final perTruckFareController = TextEditingController();

  RxDouble subTotal = 0.0.obs;
  RxDouble remainingDue = 0.0.obs;

  String cftMeasurementDetails = '';
  double _singleTruckCft = 0.0;

  void calculateInvoice() {
    double rate = double.tryParse(rateController.text.trim()) ?? 0.0;
    int truckCount = int.tryParse(truckCountController.text.trim()) ?? 1;

    if (_singleTruckCft > 0) {
      double totalCft = _singleTruckCft * truckCount;
      quantityController.text = totalCft.toStringAsFixed(2);
    }

    double qty = double.tryParse(quantityController.text.trim()) ?? 0.0;
    double perTruckFare =
        double.tryParse(perTruckFareController.text.trim()) ?? 0.0;
    double totalTransport = truckCount * perTruckFare;

    double paid = double.tryParse(paidAmountController.text.trim()) ?? 0.0;

    subTotal.value = (rate * qty) + totalTransport;
    remainingDue.value = subTotal.value - paid;
  }

  void updateCftDetails({
    required double lFt,
    required double lIn,
    required double wFt,
    required double wIn,
    required double hFt,
    required double hIn,
  }) {
    double totalL = lFt + (lIn / 12);
    double totalW = wFt + (wIn / 12);
    double totalH = hFt + (hIn / 12);

    _singleTruckCft = totalL * totalW * totalH;

    cftMeasurementDetails =
        "${lFt.toStringAsFixed(0)}' ${lIn.toStringAsFixed(0)}\" x "
        "${wFt.toStringAsFixed(0)}' ${wIn.toStringAsFixed(0)}\" x "
        "${hFt.toStringAsFixed(0)}' ${hIn.toStringAsFixed(0)}\"";

    // cftMeasurementDetails =
        // "${totalL.toStringAsFixed(1)}' x ${totalW.toStringAsFixed(1)}' x ${totalH.toStringAsFixed(1)}'";
  }

  Future<Uint8List> generatePdfData() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          int truckCount = int.tryParse(truckCountController.text.trim()) ?? 1;
          double perTruckFare =
              double.tryParse(perTruckFareController.text.trim()) ?? 0.0;
          double totalTransport = truckCount * perTruckFare;

          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'INVOICE / BILL',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text('Construction Supply Management'),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Date: ${DateTime.now().toString().split(' ')[0]}',
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 24),
                pw.Divider(),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Client Details:',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  clientNameController.text.isEmpty
                      ? 'Walking Client'
                      : clientNameController.text,
                ),
                pw.SizedBox(height: 24),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey100,
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Description',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Qty / CFT',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Rate',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),

                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Total',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                itemNameController.text.isEmpty
                                    ? 'Construction Materials'
                                    : itemNameController.text,
                              ),
                              if (cftMeasurementDetails.isNotEmpty) ...[
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  'Single Truck Dims: $cftMeasurementDetails',
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    color: PdfColors.grey800,
                                  ),
                                ),
                                pw.Text(
                                  'Single Truck Vol: ${_singleTruckCft.toStringAsFixed(2)} CFT',
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    color: PdfColors.grey800,
                                  ),
                                ),
                              ],
                              pw.SizedBox(height: 4),
                              pw.Text(
                                'Total Trucks: $truckCount',
                                style: pw.TextStyle(
                                  fontSize: 11,
                                  color: PdfColors.grey800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            quantityController.text.isEmpty
                                ? '0.00'
                                : quantityController.text,
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            rateController.text.isEmpty
                                ? '0.00'
                                : rateController.text,
                          ),
                        ),

                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            ((double.tryParse(rateController.text) ?? 0) *
                                    (double.tryParse(quantityController.text) ??
                                        0))
                                .toStringAsFixed(2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 24),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Transport Cost ($truckCount x ${perTruckFare.toStringAsFixed(2)}): BDT ${totalTransport.toStringAsFixed(2)}',
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Grand Total: BDT ${subTotal.value.toStringAsFixed(2)}',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Paid Amount: BDT ${(double.tryParse(paidAmountController.text) ?? 0.0).toStringAsFixed(2)}',
                        ),
                        pw.SizedBox(height: 4),
                        pw.Divider(),
                        pw.Text(
                          'Remaining Due: BDT ${remainingDue.value.toStringAsFixed(2)}',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: remainingDue.value > 0
                                ? PdfColors.red
                                : PdfColors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 48),
                pw.Divider(),
                pw.SizedBox(height: 8),
                pw.Center(
                  child: pw.Text(
                    'Thank you for your business!',
                    style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  void onClose() {
    clientNameController.dispose();
    itemNameController.dispose();
    rateController.dispose();
    quantityController.dispose();
    paidAmountController.dispose();
    truckCountController.dispose();
    perTruckFareController.dispose();
    super.onClose();
  }
}
