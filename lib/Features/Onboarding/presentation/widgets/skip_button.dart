import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/pages/choose_login_or_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04),
      child: Align(
        alignment: LocalizeAndTranslate.getLanguageCode() == 'en' ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (c) => ChooseLoginOrRegisterScreen()),
            );
          },
          child: Container(
            height: Shared.height * 0.05,
            width: Shared.width * 0.22,
            decoration: BoxDecoration(
              color: isDark ? kTransparentColor : kWhiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? kGreyColor : kPrimaryColor, width: 2),
            ),
            child: Center(
              child: Text(
                kSkip.tr(),
                style: GoogleFonts.notoSansArabic(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDark ? kGreyColor : kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
