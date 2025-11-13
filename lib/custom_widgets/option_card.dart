import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  final double? height;
  final double? width;
  final IconData? icon;

  const OptionCard({
    super.key,
    required this.onTap,
    required this.name,
    this.height,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 28, color: theme.colorScheme.primary),
                const SizedBox(height: 8),
              ],
              Text(
                name,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
