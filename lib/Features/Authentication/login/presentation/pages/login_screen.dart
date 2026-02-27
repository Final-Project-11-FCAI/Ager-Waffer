import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/forget_password_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/forget_password_bottom_sheet.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/email_text_field.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/password_text_field.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logo_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isChecked = false;
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
          foregroundColor: kWhiteColor,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04, vertical: Shared.height * 0.08),
              child: Column(
                children: [
                  EmailTextField(
                    icon: Icon(Icons.email_outlined),
                    label: 'البريد الالكتروني',
                  ),
                  Gap(30.h),
                  PasswordTextField(
                    icon: Icon(Icons.lock_outline),
                    label: 'كلمة المرور',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                          builder: (BuildContext context) =>
                          FractionallySizedBox(
                          heightFactor: 0.85,
                          child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.r),
                              ),
                              child: ForgetPasswordBottomSheet())));
                        },
                        child: Text(
                          'هل نسيت كلمة المرور؟',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(40.h),
                  ButtonApp(
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                              (route) => false,
                        );
                      },
                      text: 'تسجيل الدخول', color: kPrimaryColor),
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
                          height: 83,
                          width: 83,
                        ),
                      ),
                      LogoIcon(path: "assets/images/Google.png", onTap: () {}),
                    ],
                  ),
                  Gap(20.h),
                  RichText(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
