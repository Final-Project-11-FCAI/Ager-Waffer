import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Onboarding/models/Onboarding_Data.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/pages/choose_login_or_register_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/skip_button.dart';
import 'package:ager_waffer/Features/Splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          buildDesign(isTopLeft: true),
          Gap(Shared.height * 0.055),
          SkipButton(),
          Gap(Shared.height * 0.05),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingDate.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) => Column(
                children: [
                  Image.asset(
                    onboardingDate[index].image,
                    width: Shared.width * 0.9,
                  ),
                  Gap(Shared.height * 0.02),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: onboardingDate[index].title,
                          style: font24LightPrimarySemiBold,
                        ),
                        _currentPage == 0
                            ? TextSpan(
                                text: 'أجر و وفر',
                                style: font24PrimarySemiBold,
                              )
                            : const TextSpan(),
                      ],
                    ),
                  ),
                  Gap(Shared.height * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Shared.width * 0.1,
                    ),
                    child: Text(
                      onboardingDate[index].subTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSansArabic(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Shared.height * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingDate.length,
                        (val) => Container(
                          margin: const EdgeInsets.only(right: 7),
                          height: Shared.height * 0.032,
                          width: Shared.width * 0.032,
                          decoration: BoxDecoration(
                            color: _currentPage == val
                                ? kPrimaryColor
                                : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Shared.width * 0.04,
                      vertical: Shared.height * 0.015,
                    ),
                    child: ButtonApp(
                      text: 'التالي',
                      color: kPrimaryColor,
                      onPressed: () {
                        if (_currentPage == onboardingDate.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (c) => ChooseLoginOrRegisterScreen(),
                            ),
                          );
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      currentPage: _currentPage,
                      controller: _controller,
                    ),
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

