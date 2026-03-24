import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Helper/app_state.dart';
import 'package:ager_waffer/Base/common/input_validation.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/authentication_bloc.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/verification_code_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/email_text_field.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgetPasswordBottomSheet extends StatefulWidget {
  const ForgetPasswordBottomSheet({super.key});

  @override
  State<ForgetPasswordBottomSheet> createState() =>
      _ForgetPasswordBottomSheetState();
}

class _ForgetPasswordBottomSheetState extends State<ForgetPasswordBottomSheet> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  void checkFields() {
    final isValid =
        emailController.text.isNotEmpty &&
        InputValidation.isValidEmail(emailController.text);
    setState(() {
      isButtonEnabled = isValid;
    });
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(checkFields);
  }

  @override
  void dispose() {
    emailController.removeListener(checkFields);
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Shared.width * 0.05,
            vertical: Shared.height * 0.1,
          ),
          child: BlocListener<AuthenticationBloc, AppState>(
            bloc: authenticationBloc,
            listener: (context, state) {
              if (state is ForgetPasswordLoading) {
                Shared.showLoadingDialog(context: context);
              } else if (state is ForgetPasswordDoneState) {
                Shared.dismissDialog(context: context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (c) =>
                        VerificationCodeScreen(email: emailController.text),
                  ),
                );
              } else if (state is ForgetPasswordErrorLoadingState) {
                Shared.dismissDialog(context: context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message ?? "حدث خطأ ما يرجى المحاولة في وقت لاحق",
                    ),
                  ),
                );
              }
            },
            child: Form(
              key: formKey,
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
                    },
                  ),
                  Gap(Shared.height * 0.12.h),
                  ButtonApp(
                    onPressed: isButtonEnabled
                        ? () {
                            if (formKey.currentState!.validate()) {
                              authenticationBloc.add(
                                ForgetPasswordEvent(
                                  email: emailController.text,
                                ),
                              );
                            }
                          }
                        : null,

                    text: 'استمرار',
                    color: kPrimaryColor,
                    borderRadius: Shared.width * 0.04.h,
                  ),
                  Gap(20.h),
                  ButtonApp(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'إلغاء',
                    color: kPrimaryColor,
                    borderRadius: Shared.width * 0.04.h,
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
