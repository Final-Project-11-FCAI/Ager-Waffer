import 'dart:async';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Helper/app_state.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/authentication_bloc.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/reset_password_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key, required this.email});

  final String email;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  void startTimer() {
    secondsRemaining = 60;
    enableResend = false;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() => secondsRemaining--);
      } else {
        setState(() => enableResend = true);
        timer.cancel();
      }
    });
  }

  void checkOtp() {
    setState(() {
      isButtonEnabled = otpController.text.length == 4;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    otpController.addListener(checkOtp);
  }

  @override
  void dispose() {
    timer?.cancel();
    otpController.removeListener(checkOtp);
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.h,
      textStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthenticationBloc, AppState>(
        bloc: authenticationBloc,
        listener: (context, state) {
          if (state is VerifyOtpLoading) {
            Shared.showLoadingDialog(context: context);
          } else if (state is VerifyOtpDoneState) {
            Shared.dismissDialog(context: context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (c) => ResetPasswordScreen(email: widget.email,),
              ),
            );
          } else if (state is VerifyOtpErrorLoadingState) {
            Shared.dismissDialog(context: context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message ?? kSomethingWentWrong.tr(),
                ),
              ),
            );
          }
        },
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Shared.width * 0.06.w,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          size: Shared.width * 0.25.w,
                          color: kDoneColor,
                        ),
                        Gap(20.h),
                        Text(
                          kVerifyEmailTitle.tr(),
                          textAlign: TextAlign.center,
                          style: font24PrimarySemiBold.copyWith(
                            fontWeight: bold,
                            color: kDoneColor,
                          ),
                        ),
                        Gap(10.h),
                        Text(
                          kVerifyEmailDesc.tr(),
                          textAlign: TextAlign.center,
                          style: font20PrimaryMedium.copyWith(color: kDoneColor),
                        ),
                        Gap(5.h),
                        Text(
                          widget.email,
                          style: font20PrimaryMedium.copyWith(color: kDoneColor),
                        ),
                        Gap(40.h),
                        Pinput(
                          length: 4,
                          controller: otpController,
                          defaultPinTheme: defaultPinTheme,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: kBlueColor),
                            ),
                          ),
                        ),
                        Gap(40.h),
                        ButtonApp(
                            onPressed: isButtonEnabled
                                ? () {
                              if (formKey.currentState!.validate()) {
                                authenticationBloc.add(
                                  VerifyOtpEvent(
                                    email: widget.email,
                                    otp: otpController.text,
                                  ),
                                );
                              }
                            }
                                : null,
                          text: kConfirm.tr(),
                          color: kPrimaryColor,
                          borderRadius: Shared.width * 0.04.h,
                        ),
                        Gap(10.h),
                        enableResend
                            ? TextButton(
                                onPressed: startTimer,
                                child: Text(
                                  kResendCode.tr(),
                                  style: font20PrimaryMedium.copyWith(
                                    color: kBlackColor,
                                  ),
                                ),
                              )
                            : Text(
                          "${kResendIn.tr()} $secondsRemaining ${kSeconds.tr()}",
                                style: font16BlackSemiBold.copyWith(
                                  color: kGreyColor,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
