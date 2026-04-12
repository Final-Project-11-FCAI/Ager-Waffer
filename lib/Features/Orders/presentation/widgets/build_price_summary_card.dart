import 'package:flutter/material.dart';
import 'package:ager_waffer/Base/common/theme.dart';

class BuildPriceSummaryCard extends StatelessWidget {
  const BuildPriceSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "ملخص السعر",
              style: font14BlackBold.copyWith(color: kPrimaryColor),
            ),
          ),
          const SizedBox(height: 15),

          // دالة داخلية أو يمكنك تحويلها لـ Widget منفصل أيضاً
          _buildPriceRow("سعر الإيجار/ اليوم:", "100 جنيه"),
          const SizedBox(height: 10),
          _buildPriceRow("التأمين", "200 جنيه"),
          const SizedBox(height: 10),

          const Divider(thickness: 1, height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "إجمالي المبلغ:",
                style: font14BlackBold.copyWith(fontSize: 13),
              ),
              Text(
                "700 جنيه",
                style: font14BlackBold.copyWith(color: kPrimaryColor, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: font14BlackBold.copyWith(fontSize: 12)),
        Text(value, style: font14BlackBold.copyWith(fontSize: 12)),
      ],
    );
  }
}