import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: false,
        title: Text(kAboutUs.tr(), style: font24LightPrimarySemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Image.asset("assets/images/about_us_logo.png"),
                Gap(25.h),
                _buildText(kAboutParagraph1.tr()),
                Gap(15.h),
                _buildText(kAboutParagraph2.tr()),
                Gap(15.h),
                _buildText(kAboutParagraph3.tr()),
                Gap(15.h),
                _buildText(kAboutParagraph4.tr()),
                Gap(15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: font14BlackBold.copyWith(fontWeight: medium, color: kBlackColor, height: 1.6),
    );
  }
}
