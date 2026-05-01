import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? kMoreDarkModeColor : null,
      appBar: AppBar(
        forceMaterialTransparency: false,
        backgroundColor: isDark ? kDarkModeColor : null,
        title: Text(kAboutUs.tr(), style: font24LightPrimarySemiBold.copyWith(color: isDark ? kWhiteColor : kLightPrimaryColor)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Shared.height * 0.03.h),
                  child: Image.asset("assets/images/about_logo.png"),
                ),
                Gap(25.h),
                _buildText(kAboutParagraph1.tr(), context),
                Gap(15.h),
                _buildText(kAboutParagraph2.tr(), context),
                Gap(15.h),
                _buildText(kAboutParagraph3.tr(), context),
                Gap(15.h),
                _buildText(kAboutParagraph4.tr(), context),
                Gap(15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text, BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: font14BlackBold.copyWith(fontWeight: medium, color: isDark ? kWhiteColor : kLightPrimaryColor, height: 1.9.sp),
    );
  }
}
