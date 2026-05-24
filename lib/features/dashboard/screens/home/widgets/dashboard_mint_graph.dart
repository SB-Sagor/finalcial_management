import 'package:flutter/material.dart';
import '../../../../../utils/constraints/u_colors.dart';

class UDashboardMintGraph extends StatefulWidget {
  const UDashboardMintGraph({super.key});

  @override
  State<UDashboardMintGraph> createState() => _UDashboardMintGraphState();
}

class _UDashboardMintGraphState extends State<UDashboardMintGraph> {
  String selectedTimeframe = 'দৈনিক';

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'বিক্রয় বিশ্লেষণ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // --- 1. Timeframe Filter Row ---
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['দৈনিক', 'সাপ্তাহিক', 'মাসিক', 'বার্ষিক'].map((
              timeframe,
            ) {
              bool isSelected = selectedTimeframe == timeframe;
              return GestureDetector(
                onTap: () => setState(() => selectedTimeframe = timeframe),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFF3A63B)
                        : (isLight
                              ? Colors.grey.shade100
                              : const Color(0xFF16171D)),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : (isLight
                                ? Colors.grey.shade300
                                : const Color(0xFF262833)),
                    ),
                  ),
                  child: Text(
                    timeframe,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Colors.black
                          : (isLight ? Colors.black87 : Colors.grey.shade400),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // --- 2. Horizontal Metrics Row ---
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildMetricCard(
                'বিক্রয়',
                '৳৮.৪ লক্ষ',
                const Color(0xFF00E676),
                isLight,
              ),
              _buildMetricCard(
                'লাভ',
                '৳২.৩ লক্ষ',
                const Color(0xFF29B6F6),
                isLight,
              ),
              _buildMetricCard(
                'বকেয়া',
                '৳১.৭ লক্ষ',
                const Color(0xFFFFA726),
                isLight,
              ),
              _buildMetricCard(
                'লস',
                '৳৩২ হাজার',
                const Color(0xFFEF5350),
                isLight,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // --- 3. Product Breakdown Bars ---
        const Text(
          'মাসিক বিক্রয় — পণ্য অনুযায়ী',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        _buildProductProgressBar(
          'বালু',
          0.85,
          '৳৩.২ল',
          const Color(0xFF4285F4),
          isLight,
        ),
        _buildProductProgressBar(
          'পাথর',
          0.70,
          '৳২.৬ল',
          const Color(0xFF2ECC71),
          isLight,
        ),
        _buildProductProgressBar(
          'ইট',
          0.55,
          '৳১.৮ল',
          const Color(0xFFA855F7),
          isLight,
        ),
        _buildProductProgressBar(
          'রড',
          0.25,
          '৳৮২হা',
          const Color(0xFFF1A83A),
          isLight,
        ),
        const SizedBox(height: 24),

        // --- 4. Monthly Trend Segment ---
        const Text(
          'মাসওয়ারি ট্রেন্ড',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isLight ? Colors.grey.shade50 : const Color(0xFF121318),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isLight ? Colors.grey.shade200 : const Color(0xFF1F212A),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: CustomPaint(
                  painter: PremiumTrendPainter(isLight: isLight),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['জান', 'ফেব্রু', 'মার্চ', 'এপ্রিল', 'মে'].map((
                  month,
                ) {
                  bool isMay = month == 'মে';
                  return Text(
                    month,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isMay ? FontWeight.bold : FontWeight.normal,
                      color: isMay ? const Color(0xFFFFA726) : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'মে মাসে সর্বোচ্চ বিক্রয় ৳৮.৪ লক্ষ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String label,
    String amount,
    Color color,
    bool isLight,
  ) {
    return Container(
      width: 135,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : const Color(0xFF16171D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLight ? Colors.grey.shade200 : const Color(0xFF222431),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductProgressBar(
    String label,
    double value,
    String amountText,
    Color barColor,
    bool isLight,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 45,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: isLight
                        ? Colors.grey.shade100
                        : const Color(0xFF1B1C24),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: value,
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      amountText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumTrendPainter extends CustomPainter {
  final bool isLight;
  PremiumTrendPainter({required this.isLight});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFFFA726).withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw reference horizontal guides lines matching the original style
    for (int i = 1; i <= 3; i++) {
      double y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
