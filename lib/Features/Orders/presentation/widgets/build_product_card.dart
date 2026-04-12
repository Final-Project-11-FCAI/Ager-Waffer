import 'package:flutter/material.dart';
import 'package:ager_waffer/Base/common/theme.dart';

class BuildProductCard extends StatelessWidget {
  const BuildProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.camera_alt, color: kGreyColor),
          ),
          const SizedBox(width: 20),
          // تفاصيل المنتج
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("كاميرا Canon EOS", style: font14BlackBold),
                const SizedBox(height: 4),
                Text(
                  "معدات تصوير احترافية",
                  style: font20BoldGreyRegular.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
