import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constraints/u_colors.dart';

class UPaymentMethodSelector extends StatelessWidget {
  const UPaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  final String selectedMethod;
  final Function(String) onMethodSelected;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final List<String> methods = ['Cash', 'bKash', 'Bank'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'payment_method'.tr,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isLight ? UColors.textSecondaryLight : UColors.textSecondaryDark,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: methods.map((method) {
            final isSelected = selectedMethod == method;
            return Expanded(
              child: GestureDetector(
                onTap: () => onMethodSelected(method),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? UColors.lossRed.withOpacity(0.08)
                        : (isLight ? Colors.grey.shade50 : UColors.surfaceDark),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? UColors.lossRed : (isLight ? Colors.grey.shade300 : UColors.borderDark),
                      width: isSelected ? 1.2 : 1,
                    ),
                  ),
                  child: Text(
                    method,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected
                          ? UColors.lossRed
                          : (isLight ? Colors.black : UColors.textPrimaryDark),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}