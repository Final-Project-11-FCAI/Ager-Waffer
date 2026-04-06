import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gap/gap.dart';

class RentalTermsScreen extends StatefulWidget {
  const RentalTermsScreen({super.key});

  @override
  State<RentalTermsScreen> createState() => _RentalTermsScreenState();
}

class _RentalTermsScreenState extends State<RentalTermsScreen> {
  List<bool> termsChecked = [false, false, false, false, false];

  final List<String> terms = [
    kTerm1.tr(),
    kTerm2.tr(),
    kTerm3.tr(),
    kTerm4.tr(),
    kTerm5.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w, vertical: Shared.height * 0.025.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
          kRentalTermsTitle.tr(),
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
              child: Text(
                kAgree.tr(),
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
