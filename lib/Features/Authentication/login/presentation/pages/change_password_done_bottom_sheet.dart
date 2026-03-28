import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ChangePasswordDoneBottomSheet extends StatelessWidget {
  const ChangePasswordDoneBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04, vertical: Shared.height * 0.04),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/done_image.png'),
              Gap(20.h),
              Text(
                  kPasswordChanged.tr(),
                style: font24PrimarySemiBold.copyWith(fontWeight: bold, color: kDoneColor)
              ),
              Text(
                  kLoginNowDesc.tr(),
                style: font20PrimaryMedium.copyWith(color: kBlackColor)
              ),
              Gap(50.h),
              ButtonApp(
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                      context,
                      'LoginScreen',
                    );
                  },
                  text: kLoginNow.tr(), color: kDoneColor,borderRadius: Shared.width * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
