import 'package:flutter/material.dart';
import '../../../../../utils/constraints/u_colors.dart';
import '../../../../../utils/constraints/u_sizes.dart';

class UQuickActionCard extends StatelessWidget {
  const UQuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(USizes.cardRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(USizes.cardRadius),
          border: Border.all(
            color: isLight ? Colors.grey.shade200 : UColors.borderDark,
            width: 1,
          ),
          boxShadow: isLight
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: USizes.fontSizeSm,
                fontWeight: FontWeight.w600,
                color: isLight ? UColors.textPrimaryLight : UColors.textPrimaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}