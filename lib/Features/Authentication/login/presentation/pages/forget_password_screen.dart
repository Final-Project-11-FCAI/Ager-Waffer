import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/change_password_done_bottom_sheet.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/register_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/email_text_field.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/password_text_field.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logo_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Shared.width * 0.04,
              vertical: Shared.height * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'كلمة المرور الجديدة',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
                Gap(10.h),
                PasswordTextField(
                  icon: Icon(Icons.lock_outline),
                  label: 'كلمة المرور',
                ),
                Gap(40),
                Text(
                  'تأكيد كلمة المرور',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: kPrimaryColor,
                  ),
                ),
                Gap(10.h),
                PasswordTextField(
                  icon: Icon(Icons.lock_outline),
                  label: 'تأكيد كلمة المرور',
                ),
                Gap(50.h),
                ButtonApp(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: false,
                        isDismissible: false,
                        builder: (BuildContext context) =>
                            FractionallySizedBox(
                                heightFactor: 0.55,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.r),
                                    ),
                                    child: ChangePasswordDoneBottomSheet())));
                  },
                  text: 'تحديث كلمة المرور',
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
                      padding: EdgeInsets.symmetric(
                        horizontal: Shared.width * 0.02,
                      ),
                      child: LogoIcon(
                        path: 'assets/images/Apple.png',
                        onTap: () {},
                        height: 83,
                        width: 83,
                      ),
                    ),
                    LogoIcon(path: "assets/images/Google.png", onTap: () {}),
                  ],
                ),
                Gap(20.h),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "  ليس لديك حساب ؟",
                          style: TextStyle(
                            color: Color(0xff5588A3),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                context,
                                'RegisterScreen',
                              );
                            },
                        ),
                        TextSpan(
                          text: " أنشيء حسابًا الأن",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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
