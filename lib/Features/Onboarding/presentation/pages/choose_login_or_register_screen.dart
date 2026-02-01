import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/login_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/register_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseLoginOrRegisterScreen extends StatelessWidget {
  ChooseLoginOrRegisterScreen({super.key});

  final PageController _controller = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          buildDesign(isTopLeft: true),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Shared.width * 0.04,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png',),
                  Text(
                    'أبدأ رحلتك الآن',
                    style: GoogleFonts.notoSansArabic(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: kLightPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Shared.height * 0.05,
                      bottom: Shared.height * 0.025,),
                    child: ButtonApp(
                      onPressed: () {
                        customAnimatedPushNavigation(context, RegisterScreen());
                      },
                      text: 'إنشاء حساب جديد',
                      color: kPrimaryColor,
                    ),
                  ),
                  ButtonApp(
                    onPressed: () {
                      customAnimatedPushNavigation(context, LoginScreen());
                    },
                    text: 'لديك حساب؟ تسجيل الدخول',
                    color: kWhiteColor,
                  ),
                ],
              ),
            ),
          ),
          buildDesign(isTopLeft: false),
        ],
      ),
    );
  }
}
