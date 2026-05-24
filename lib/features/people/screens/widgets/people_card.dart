import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constraints/u_colors.dart';
import '../../../../utils/constraints/u_sizes.dart';

class UPeopleCard extends StatelessWidget {
  const UPeopleCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.initials,
    required this.dueAmount,
    required this.isClient,
    required this.onTap,
  });

  final String name;
  final String subtitle;
  final String initials;
  final int dueAmount;
  final bool isClient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    final Color accentColor = isClient ? UColors.accentGold : UColors.accentBlue;
    final Color avatarBg = accentColor.withOpacity(0.12);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(USizes.cardRadius),
        border: Border.all(
          color: isLight ? Colors.grey.shade200 : UColors.borderDark,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(USizes.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(USizes.cardPadding),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(color: avatarBg, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: TextStyle(color: accentColor, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: USizes.fontSizeMd + 1,
                        fontWeight: FontWeight.w600,
                        color: isLight ? UColors.textPrimaryLight : UColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: UColors.textSecondaryDark),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    dueAmount > 0 ? '৳$dueAmount' : 'clear_badge'.tr,
                    style: TextStyle(
                      fontSize: USizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                      color: dueAmount > 0 ? UColors.lossRed : UColors.profitGreen,
                    ),
                  ),
                  if (dueAmount > 0) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: UColors.lossRed.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'due_badge'.tr,
                        style: const TextStyle(color: UColors.lossRed, fontSize: 9, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}