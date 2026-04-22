import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/login_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/register_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ChooseLoginOrRegisterScreen extends StatelessWidget {
  ChooseLoginOrRegisterScreen({super.key});

  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
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
                      kStartJourney.tr(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSansArabic(
                        fontSize: 26.sp,
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
                        text: kCreateNewAccount.tr(),
                        color: kPrimaryColor,
                      ),
                    ),
                    ButtonApp(
                      onPressed: () {
                        customAnimatedPushNavigation(context, LoginScreen());
                      },
                      text: kHaveAccountLogin.tr(),
                      color: kWhiteColor,
                    ),
                  ],
                ),
              ),
            ),
            buildDesign(isTopLeft: false),
          ],
        ),
      ),
    );
  }
}