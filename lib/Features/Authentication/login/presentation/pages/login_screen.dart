import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/input_validation.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/login_bloc.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/login_state.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/forget_password_bottom_sheet.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/email_text_field.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/password_text_field.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logo_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    emailController.addListener(checkFields);
    passwordController.addListener(checkFields);
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.removeListener(checkFields);
    passwordController.removeListener(checkFields);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isButtonEnabled = false;

  void checkFields() {
    final isValid =
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        InputValidation.isValidEmail(emailController.text) &&
        InputValidation.passwordValidator(passwordController.text) == null;

    setState(() {
      isButtonEnabled = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: kPrimaryColor,
          foregroundColor: kWhiteColor,
          title: Container(
            alignment: Alignment.centerLeft,
            child: LogoAsText(),
          ),
        ),
        body: BlocListener<LoginBloc, LoginState>(
          bloc: loginBloc,
          listener: (context, state) {
            if (state.status == loginStatus.loading) {
              Shared.showLoadingDialog(context: context);
            } else if (state.status == loginStatus.success) {
              Shared.dismissDialog(context: context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (c) => BlocProvider(
                    create: (_) => BottomNavCubit(),
                    child: const HomeLayoutScreen(),
                  ),
                ),
              );
            } else if (state.status == loginStatus.failure) {
              Shared.dismissDialog(context: context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.failureMessage ?? kSomethingWentWrong.tr(),
                  ),
                ),
              );
            }
          },
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Shared.width * 0.04,
                  vertical: Shared.height * 0.08,
                ),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          EmailTextField(
                            emailController: emailController,
                            icon: Icon(Icons.email_outlined),
                            label: kEmail.tr(),
                            validator: (value) {
                              return InputValidation.isValidEmail(value!)
                                  ? null
                                  : kEnterValidEmail.tr();
                            },
                          ),
                          Gap(30.h),
                          PasswordTextField(
                            passwordController: passwordController,
                            icon: Icon(Icons.lock_outline),
                            label: kPassword.tr(),
                            validator: (value) {
                              return InputValidation.passwordValidator(value!);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) =>
                                        FractionallySizedBox(
                                          heightFactor: 0.85,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(25.r),
                                            ),
                                            child: ForgetPasswordBottomSheet(),
                                          ),
                                        ),
                                  );
                                },
                                child: Text(
                                  kforgotPasswordKey.tr(),
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(40.h),
                          ButtonApp(
                            onPressed: isButtonEnabled
                                ? () async {
                                    if (formKey.currentState!.validate()) {
                                      loginBloc.add(
                                        LoginEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    }

                                    // if (formKey.currentState!.validate()) {
                                    //   await FirebaseAuth.instance
                                    //       .signInWithEmailAndPassword(
                                    //         email: emailController.text,
                                    //         password: passwordController.text,
                                    //       )
                                    //       .then(
                                    //         (value) => Navigator.pushAndRemoveUntil(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //             builder: (context) => BlocProvider(
                                    //               create: (_) => BottomNavCubit(),
                                    //               child: const HomeLayoutScreen(),
                                    //             ),
                                    //           ),
                                    //           (route) => false,
                                    //         ),
                                    //       )
                                    //       .onError(
                                    //         (error, stackTrace) =>
                                    //             ScaffoldMessenger.of(
                                    //               context,
                                    //             ).showSnackBar(
                                    //               SnackBar(
                                    //                 content: Text('There is a problem with the password or email. Please try again'),
                                    //               ),
                                    //             ),
                                    //       );
                                    // }
                                    // Shared.dismissDialog(context: context);
                                  }
                                : null,
                            text: kLogin.tr(),
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
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
                          kloginWithKey.tr(),
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
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${knoAccountKey.tr()} ",
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
                            text: kcreateAccountNowKey.tr(),
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    'RegisterScreen',
                                  );
                                }
                          ),
                        ],
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
