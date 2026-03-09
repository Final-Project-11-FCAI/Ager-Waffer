import 'dart:async';

import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/forget_password_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  void startTimer() {
    secondsRemaining = 60;
    enableResend = false;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() => secondsRemaining--);
      } else {
        setState(() => enableResend = true);
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.h,
      textStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Shared.width * 0.06.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      size: Shared.width * 0.25.w,
                      color: kDoneColor,
                    ),
                    Gap(20.h),
                    Text(
                      "تأكيد البريد الإلكتروني",
                      textAlign: TextAlign.center,
                      style: font24PrimarySemiBold.copyWith(
                        fontWeight: bold,
                        color: kDoneColor,
                      ),
                    ),
                    Gap(10.h),
                    Text(
                      "أدخل رمز التحقق المرسل إلى بريدك الإلكتروني",
                      textAlign: TextAlign.center,
                      style: font20PrimaryMedium.copyWith(color: kDoneColor),
                    ),
                    Gap(5.h),
                    Text(
                      "example@gmail.com",
                      style: font20PrimaryMedium.copyWith(color: kDoneColor),
                    ),
                    Gap(40.h),
                    Pinput(
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: kBlueColor),
                        ),
                      ),
                    ),
                    Gap(40.h),
                    ButtonApp(
                      onPressed: () {
                        customAnimatedPushNavigation(
                          context,
                          ForgetPasswordScreen(),
                        );
                      },
                      text: 'تأكيد',
                      color: kPrimaryColor,
                      borderRadius: Shared.width * 0.04.h,
                    ),
                    Gap(10.h),
                    enableResend
                        ? TextButton(
                            onPressed: startTimer,
                            child: Text(
                              "إعادة إرسال الرمز",
                              style: font20PrimaryMedium.copyWith(
                                color: kBlackColor,
                              ),
                            ),
                          )
                        : Text(
                            "إعادة الإرسال خلال $secondsRemaining ثانية",
                            style: font16BlackSemiBold.copyWith(
                              color: kGreyColor,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
