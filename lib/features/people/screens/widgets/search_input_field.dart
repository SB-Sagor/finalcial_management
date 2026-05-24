import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constraints/u_colors.dart';

class USearchInputField extends StatelessWidget {
  const USearchInputField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
  });

  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: isLight ? Colors.black : UColors.textPrimaryDark, fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: UColors.textMutedDark, fontSize: 13),
          prefixIcon: const Icon(Iconsax.search_normal_1, size: 18, color: UColors.textSecondaryDark),
          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
            onTap: () {
              controller.clear();
              onChanged('');
            },
            child: const Icon(Icons.cancel_rounded, size: 18, color: Colors.grey),
          )
              : null,
          filled: true,
          fillColor: isLight ? Colors.grey.shade100 : UColors.surfaceDark,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: isLight ? Colors.grey.shade400 : Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: UColors.profitGreen, width: 1),
          ),
        ),
      ),
    );
  }
}