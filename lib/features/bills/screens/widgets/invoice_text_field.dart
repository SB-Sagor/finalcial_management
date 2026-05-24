import 'package:flutter/material.dart';
import '../../../../utils/constraints/u_colors.dart';

class UInvoiceTextField extends StatelessWidget {
  const UInvoiceTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isLight ? UColors.textSecondaryLight : UColors.textSecondaryDark,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: isLight ? Colors.black : UColors.textPrimaryDark, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: UColors.textMutedDark, fontSize: 13),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 18, color: UColors.textSecondaryDark) : null,
            filled: true,
            fillColor: isLight ? Colors.grey.shade50 : UColors.surfaceDark,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: isLight ? Colors.grey.shade300 : UColors.borderDark),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: UColors.profitGreen, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}