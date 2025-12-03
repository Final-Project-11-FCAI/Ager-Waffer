import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          buildDesign(isTopLeft: true),
          Expanded(
            child: Center(
                child: Image.asset('assets/images/logo.png',)),
          ),
          buildDesign(isTopLeft: false),
        ],
      ),
    );
  }
}

Align buildDesign({required bool isTopLeft}) {
  return Align(
    alignment: isTopLeft ? Alignment.topLeft : Alignment.bottomRight,
    child: Container(
      height: Shared.height * 0.1,
      width: Shared.width * 0.25,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomRight: isTopLeft ? Radius.circular(80) : Radius.circular(0) ,
          topLeft: isTopLeft ? Radius.circular(0) : Radius.circular(80),
        ),
      ),
    ),
  );
}
