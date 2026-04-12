import 'package:flutter/material.dart';
import 'package:ager_waffer/Base/common/theme.dart';

class BuildDateCard extends StatelessWidget {
  const BuildDateCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240), // نفس لون الـ _cardDecoration
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "تاريخ الإيجار",
            style: font14BlackBold.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(height: 15),
          _buildRow("تاريخ البدء", "----"),
          const Divider(),
          _buildRow("تاريخ الانتهاء", "----"),
        ],
      ),
    );
  }

  // وضعنا الدالة هنا داخل الكلاس عشان تكون متاحة للـ Card ده
  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: font14BlackBold.copyWith(fontSize: 12),
          ),
          Text(
            value,
            style: font14BlackBold.copyWith(fontSize: 10),
          ),
        ],
      ),
    );
  }
}