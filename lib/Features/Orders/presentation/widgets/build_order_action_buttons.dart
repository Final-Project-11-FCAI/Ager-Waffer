import 'package:flutter/material.dart';
import 'package:ager_waffer/Base/common/theme.dart';

class BuildOrderActionsButtons extends StatelessWidget {
  const BuildOrderActionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          )
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Row(
        children: [
          // زر قبول الطلب
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
              },
              child: Text(
                "✓ قبول الطلب",
                style: font14BlackBold.copyWith(color: kWhiteColor),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // زر الرفض
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: kRedColor),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
              },
              child: Text(
                "✕ رفض",
                style: font14BlackBold.copyWith(color: kRedColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
