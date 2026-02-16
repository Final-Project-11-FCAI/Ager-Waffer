import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/pages/onboarding_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = "ar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.035, vertical: Shared.height * 0.16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "اختيار اللغة",
                style: font14BlackBold.copyWith(fontSize: 24),
              ),
              Gap(14.h),
              _buildLanguageButton(title: "العربية", flag: "assets/images/egypt_flag.png", value: "ar"),
              Gap(20.h),
              _buildLanguageButton(title: "English", flag: "assets/images/english_flag.png", value: "en"),
              const Spacer(),
              ButtonApp(
                isLanguageScreen: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen(),
                      ),
                    );
                  },
                text: 'استمرار',
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required String title,
    required String flag,
    required String value,
  }) {
    final bool isSelected = selectedLanguage == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        height: 70.h,
        decoration: BoxDecoration(
          color: isSelected ? kMoreLightPrimaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25.sp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(flag),
                Gap(8.w),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.white)
            else
              const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
