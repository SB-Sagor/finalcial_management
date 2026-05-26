import 'package:flutter/material.dart';

class UInvoiceTextField extends StatelessWidget {
  const UInvoiceTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.keyboardType,
    this.readOnly = false,
    this.onChanged,
    this.focusNode,
    this.onSubmitted,
    this.textInputAction,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefixIcon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
