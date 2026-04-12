import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kWhiteColor,

        appBar: AppBar(
          backgroundColor: kPrimaryColor,

          elevation: 0,
          title: Text(
            "تفاصيل الطلب",
            style: font14BlackBold.copyWith(color: kWhiteColor),
          ),
          centerTitle: true,
        ),

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProductCard(),
                    const SizedBox(height: 15),

                    _buildDateCard(),
                    const SizedBox(height: 15),

                    _buildRenterCard(),
                  ],
                ),
              ),
            ),

            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(""),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "كاميرا Canon EOS",
                  style: font14BlackBold.copyWith(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  "معدات تصوير احترافية",
                  style: font14GreyRegular.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Text(
            "تاريخ الإيجار",
            style: font20PrimaryMedium.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 15),

          _buildRow("تاريخ البدء", "05 / 04 / 2026"),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          _buildRow("تاريخ الانتهاء", "10 / 04 / 2026"),
        ],
      ),
    );
  }

  Widget _buildRenterCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "معلومات المستأجر",
              style: font20PrimaryMedium.copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(height: 15),

          _buildRowWithRate("اسم المستأجر", "أحمد محمد"),
          const SizedBox(height: 10),

          _buildRow("العنوان", "القاهرة، المعادي، شارع 9"),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("رقم التواصل"),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.red),
                  SizedBox(width: 8),
                  Text("01012345678"),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0B3C4C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text(
                "تواصل الآن",
                style: font14BlackBold.copyWith(
                  color: kWhiteColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text(
                "✓ قبول الطلب",
                style: font14BlackBold.copyWith(
                  color: kWhiteColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: kRedColor,
                side: const BorderSide(color: kRedColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text(
                "✕ رفض",
                style: font14BlackBold.copyWith(color: kRedColor, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(value),
      ],
    );
  }

  Widget _buildRowWithRate(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Row(
          children: const [
            Text("4.9"),
            SizedBox(width: 5),
            Icon(Icons.star, color: kMoreYellowColor, size: 16),
          ],
        ),
        Text(" mohamed marzouk mahmoud "),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color.fromARGB(255, 240, 240, 240),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
