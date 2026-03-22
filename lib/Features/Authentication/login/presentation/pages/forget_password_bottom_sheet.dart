import 'package:ager_waffer/Base/common/input_validation.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/forget_password_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/verification_code_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/email_text_field.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgetPasswordBottomSheet extends StatelessWidget {
  ForgetPasswordBottomSheet({super.key});

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Shared.width * 0.05,
            vertical: Shared.height * 0.1,
          ),
          child: Column(
            children: [
              Text(
                'أدخل بريدك الإلكتروني لإرسال رابط تعيين كلمة المرور',
                textAlign: TextAlign.center,
                style: font24PrimarySemiBold.copyWith(fontWeight: medium),
              ),
              Gap(40.h),
              EmailTextField(
                emailController: emailController,
                icon: Icon(Icons.email_outlined),
                label: 'البريد الالكتروني',
                  validator: (value) {
                    return InputValidation.isValidEmail(value!)
                        ? null
                        : 'Enter your email correctly';
                  }
              ),
              Gap(Shared.height * 0.12.h),
              ButtonApp(onPressed: () {
                Navigator.pop(context);
                customAnimatedPushNavigation(context, VerificationCodeScreen());
              },
                text: 'استمرار', color: kPrimaryColor, borderRadius: Shared.width * 0.04.h,),
              Gap(20.h),
              ButtonApp(onPressed: () {}, text: 'إلغاء', color: kPrimaryColor, borderRadius: Shared.width * 0.04.h,),
            ],
          ),
        ),
      ),
    );
  }
}
