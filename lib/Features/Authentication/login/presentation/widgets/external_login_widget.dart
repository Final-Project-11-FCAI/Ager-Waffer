import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/data/external_services/auth_external_services.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/external_login_bloc.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/external_login_state.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ExternalLoginWidget extends StatelessWidget {
  ExternalLoginWidget({super.key});

  final auth = AuthExternalService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          context: context,
          provider: 'google',
          text: kContinueWithGoogle.tr(),
          icon: "assets/images/Google.png",
          onTap: () async {
            final token =
            await auth.signInWithGoogleAndGetAccessToken();

            if (token != null) {
              context.read<ExternalLoginBloc>().add(
                ExternalLoginEvent(
                    provider: 'google', accessToken: token),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (c) =>
                      BlocProvider(
                        create: (_) => BottomNavCubit(),
                        child: HomeLayoutScreen(),
                      ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(kGoogleSignInFailed.tr())),
              );
            }
          },
        ),
        Gap(12.h),
        _buildButton(
          context: context,
          provider: 'facebook',
          text: kContinueWithFacebook.tr(),
          icon: "assets/images/Facebook.png",
          onTap: () async {
            final token =
            await auth.signInWithFacebookAndGetAccessToken();

            if (token != null) {
              context.read<ExternalLoginBloc>().add(
                ExternalLoginEvent(
                    provider: 'facebook', accessToken: token),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (c) =>
                      BlocProvider(
                        create: (_) => BottomNavCubit(),
                        child: HomeLayoutScreen(),
                      ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(kFacebookSignInFailed.tr())),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String provider,
    required String text,
    required String icon,
    required VoidCallback onTap,
  }) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<ExternalLoginBloc, ExternalLoginState>(
      builder: (context, state) {
        final isLoading =
            state.status == externalLoginStatus.loading;

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isLoading ? 0.7 : 1,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isLoading ? null : onTap,
              borderRadius: BorderRadius.circular(14),
              splashColor: isDark ? kButtonColor : kWhiteColor,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: double.infinity,
                height: Shared.height * 0.078.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w,),
                decoration: BoxDecoration(
                  color: isDark ? kButtonColor : kWhiteColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isDark ? kButtonColor : Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: isLoading
                        ? const SizedBox(
                      key: ValueKey("loading"),
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : Row(
                      key: const ValueKey("content"),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(icon, height: 22),
                        Gap(10.h),
                        Text(
                          text,
                          style: font16BlackSemiBold.copyWith(color: isDark ? kWhiteColor : kBlackColor)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}