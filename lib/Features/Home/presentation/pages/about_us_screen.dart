import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: false,
        title: Text(
          "About Us",
          style: font24LightPrimarySemiBold
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Gap(25.h),
                _buildText(
                  "Ager Wafer is your go-to app for discovering, exploring, and enjoying a wide variety of crispy, delicious wafers—made for every mood and every moment. From classic favorites to exciting new flavors, we bring crunch and joy right to your fingertips.",
                ),
                Gap(15.h),
                _buildText(
                  "Our mission is to make wafer shopping easier, smarter, and more enjoyable. With a user-friendly experience, secure ordering, and fast delivery, Ager Wafer ensures that your favorite treats are always within reach.",
                ),
                Gap(15.h),
                _buildText(
                  "Whether you're craving a quick bite, looking for the perfect gift, or stocking up for loved ones, Ager Wafer is here to add a little extra crunch to your day.",
                ),
                Gap(15.h),
                _buildText(
                  "Thank you for being part of the Ager Wafer family. Together, let’s crunch more, smile more, and share more happiness.",
                ),
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
      style: TextStyle(
        fontSize: 14.sp,
        height: 1.6,
        color: Colors.black87,
      ),
    );
  }
}