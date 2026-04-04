import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RenatlTermsScreen extends StatefulWidget {
  const RenatlTermsScreen({super.key});

  @override
  State<RenatlTermsScreen> createState() => _RenatlTermsScreenState();
}

class _RenatlTermsScreenState extends State<RenatlTermsScreen> {
  List<bool> termsChecked = [false, false, false, false, false];

  final List<String> terms = [
    "الالتزام بمدة الإيجار المحددة",
    "إعادة المنتج بنفس حالته وقت الاستلام",
    "يتحمل المستأجر تكلفة أي تلف ناتج عن سوء الاستخدام",
    "يتم استرداد مبلغ التأمين بعد فحص المنتج",
    "يُستخدم المنتج للغرض المتفق عليه فقط ولا يسمح بإعادة تأجيره",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w, vertical: Shared.height * 0.025.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "شروط الإيجار",
            style: font14BlackBold.copyWith(fontSize: 20),
          ),
          Gap(25.h),
          ...List.generate(terms.length, (index) => _buildTermItem(index)),
          Gap(25.h),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "موافق",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kProductDataContainerColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/terms_icon.png'),
          Gap(5.w),
          Expanded(
            child: Text(
              terms[index],
              style: font20PrimaryMedium.copyWith(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
