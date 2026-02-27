import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/email_text_field.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/password_text_field.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logo_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: kPrimaryColor,
          title: Container(alignment: Alignment.centerLeft, child: LogoAsText()),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: kBlackColor,
                            radius: Shared.width * 0.14.r,
                          ),
                          Positioned(
                              top: Shared.height * 0.105.h,
                              right: Shared.width * 0.21.w,
                              child: Image.asset('assets/images/add_icon.png'))
                        ],
                      ),
                    )
                ),
                // Gap(10.h),
                Text(
                  'إضافة صورة',
                  style: font16BlackSemiBold.copyWith(fontWeight: medium),
                ),
                Gap(30.h),
                EmailTextField(
                  icon: Icon(Icons.account_circle_outlined),
                  label: "الاسم الأول",
                  isName: true,
                ),
                Gap(30.h),
                EmailTextField(
                  icon: Icon(Icons.account_circle_outlined),
                  label: "الاسم الثاني",
                  isName: true,
                ),
                Gap(30.h),
                EmailTextField(
                  icon: Icon(Icons.email_outlined),
                  label: 'البريد الالكتروني',
                ),
                Gap(30.h),
                PasswordTextField(
                  icon: Icon(Icons.lock_outline),
                  label: 'كلمة المرور',
                ),
                Gap(30.h),
                ButtonApp(
                  onPressed: () {},
                  text: 'إنشاء حساب',
                  color: kPrimaryColor,
                ),
                Gap(10.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: kLightBlackColor,
                        endIndent: 20,
                        indent: 20,
                      ),
                    ),
                    Text(
                      'أو سجل من خلال',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: kLightBlackColor,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoIcon(path: 'assets/images/Facebook.png', onTap: () {}),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.02),
                      child: LogoIcon(
                        path: 'assets/images/Apple.png',
                        onTap: () {},
                        height: 83.h,
                        width: 83.w,
                      ),
                    ),
                    LogoIcon(path: "assets/images/Google.png", onTap: () {}),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "  لديك حساب بالفعل ؟",
                        style: TextStyle(
                          color: Color(0xff5588A3),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                              context,
                              'LoginScreen',
                            );
                          },
                      ),
                      TextSpan(
                        text: " تسجيل الدخول",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
