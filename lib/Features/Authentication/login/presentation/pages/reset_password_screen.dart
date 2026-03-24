import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Helper/app_state.dart';
import 'package:ager_waffer/Base/common/input_validation.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/authentication_bloc.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/change_password_done_bottom_sheet.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/password_text_field.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logo_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isButtonEnabled = false;

  void checkFields() {
    final isValid =
        passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty &&
            InputValidation.passwordValidator(passwordController.text) == null &&
            passwordController.text == confirmPasswordController.text;

    setState(() {
      isButtonEnabled = isValid;
    });
  }

  @override
  void initState() {
    super.initState();
    passwordController.addListener(checkFields);
    confirmPasswordController.addListener(checkFields);
  }

  @override
  void dispose() {
    passwordController.removeListener(checkFields);
    confirmPasswordController.removeListener(checkFields);
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhiteColor,
        title: Container(alignment: Alignment.centerLeft, child: LogoAsText()),
      ),
      body: BlocListener<AuthenticationBloc, AppState>(
        bloc: authenticationBloc,
        listener: (context, state) {
          if (state is ResetPasswordLoading) {
            Shared.showLoadingDialog(context: context);
          } else if (state is ResetPasswordDoneState) {
            Shared.dismissDialog(context: context);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              enableDrag: false,
              isDismissible: false,
              builder: (BuildContext context) => FractionallySizedBox(
                heightFactor: 0.55,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.r),
                  ),
                  child: ChangePasswordDoneBottomSheet(),
                ),
              ),
            );
          } else if (state is ResetPasswordErrorLoadingState) {
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
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Shared.width * 0.04,
                vertical: Shared.height * 0.04,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'كلمة المرور الجديدة',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: kPrimaryColor,
                      ),
                    ),
                    Gap(10.h),
                    PasswordTextField(
                      passwordController: passwordController,
                      icon: Icon(Icons.lock_outline),
                      label: 'كلمة المرور',
                      validator: (value) {
                        return InputValidation.passwordValidator(value!);
                      },
                    ),
                    Gap(40),
                    Text(
                      'تأكيد كلمة المرور',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: kPrimaryColor,
                      ),
                    ),
                    Gap(10.h),
                    PasswordTextField(
                      passwordController: confirmPasswordController,
                      icon: Icon(Icons.lock_outline),
                      label: 'تأكيد كلمة المرور',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        }
                        if (InputValidation.passwordValidator(value) != null) {
                          return InputValidation.passwordValidator(value);
                        }

                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    Gap(50.h),
                    ButtonApp(
                        onPressed: isButtonEnabled
                            ? () {
                          if (formKey.currentState!.validate() &&
                              passwordController.text == confirmPasswordController.text) {
                            authenticationBloc.add(
                              ResetPasswordEvent(
                                email: widget.email,
                                newPassword: passwordController.text,
                              ),
                            );
                          }
                        }
                            : null,
                      text: 'تحديث كلمة المرور',
                      color: kPrimaryColor,
                    ),
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
                        LogoIcon(
                          path: 'assets/images/Facebook.png',
                          onTap: () {},
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Shared.width * 0.02,
                          ),
                          child: LogoIcon(
                            path: 'assets/images/Apple.png',
                            onTap: () {},
                            height: 83,
                            width: 83,
                          ),
                        ),
                        LogoIcon(
                          path: "assets/images/Google.png",
                          onTap: () {},
                        ),
                      ],
                    ),
                    Gap(20.h),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
