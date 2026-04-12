import 'package:flutter/material.dart';
import 'package:ager_waffer/Base/common/theme.dart';

class BuildRenterInfoCard extends StatelessWidget {
  const BuildRenterInfoCard({super.key});

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
              "معلومات المستأجر",
              style: font14BlackBold.copyWith(color: kPrimaryColor),
            ),
          ),
          const SizedBox(height: 15),
          _buildRowWithRate("اسم المستأجر", "أحمد محمد"),
          const Divider(),
          const SizedBox(height: 10),
          _buildRow("العنوان", "القاهرة، المعادي"),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "رقم التواصل",
                style: font14BlackBold.copyWith(fontSize: 12),
              ),
              Row(
                children: [
                  const Icon(Icons.phone, color: kRedColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "01012345678",
                    style: font14BlackBold.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text(
                "تواصل الآن",
                style: font14BlackBold.copyWith(color: kWhiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: font14BlackBold.copyWith(fontSize: 12)),
          Text(value, style: font14BlackBold.copyWith(fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildRowWithRate(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: font14BlackBold.copyWith(fontSize: 12)),
        const Spacer(),
        Row(
          children: const [
            Text("( 4.9 )"),
            Icon(Icons.star, color: kOrangeColor, size: 16),
          ],
        ),
        const SizedBox(width: 8),
        Text(value, style: font14BlackBold.copyWith(fontSize: 10)),
      ],
    );
  }
}