import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Dialogs {
  static Future<void>? showDialogTest(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return AlertDialog(
          title: SizedBox(
            height: LocalizeAndTranslate.getLanguageCode() == 'ar'
                ? Shared.height * 0.395
                : Shared.height * 0.42,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.02),
              child: Column(
                children: [
                  Image.asset('assets/images/Location_image.png'),
                  SizedBox(
                    height: Shared.height * 0.015,
                  ),
                  Text(
                    'kimprove_experience.tr()',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: Shared.height * 0.015),
                    child: ButtonApp(onPressed: (){}, text: 'text', color: kPrimaryColor)
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
