import 'package:flutter/material.dart';
import '../../../../../utils/constraints/u_colors.dart';
import '../../../../../utils/constraints/u_sizes.dart';

class UDashboardBalancedContainer extends StatelessWidget {
  const UDashboardBalancedContainer({
    super.key,
    required this.title,
    required this.amount,
    required this.percentageText,
    required this.amountColor,
    required this.percentageColor,
    required this.indicatorColor,
  });

  final String title;
  final String amount;
  final String percentageText;
  final Color amountColor;
  final Color percentageColor;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(USizes.cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(USizes.cardRadius),
        border: Border.all(
          color: isLight ? Colors.grey.shade300 : UColors.borderDark,
          width: 1,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            indicatorColor,
            theme.cardColor,
          ],
          stops: const [USizes.indicatorThickness, USizes.indicatorThickness],
        ),
        boxShadow: isLight
            ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: USizes.fontSizeSm,
              fontWeight: FontWeight.w500,
              color: isLight ? UColors.textSecondaryLight : UColors.textSecondaryDark,
            ),
          ),
          const SizedBox(height: USizes.spaceBetweenItems),
          Text(
            amount,
            style: TextStyle(
              fontSize: USizes.fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: amountColor,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: USizes.spaceBetweenItems),
          Text(
            percentageText,
            style: TextStyle(
              fontSize: USizes.fontSizeSm - 1,
              fontWeight: FontWeight.w400,
              color: percentageColor,
            ),
          ),
        ],
      ),
    );
  }
}