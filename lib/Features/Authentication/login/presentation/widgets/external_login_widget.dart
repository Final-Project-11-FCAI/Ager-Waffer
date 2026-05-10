import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/data/external_services/auth_external_services.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/external_login_bloc.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/external_login_state.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ExternalLoginWidget extends StatelessWidget {
  ExternalLoginWidget({super.key});

  final auth = AuthExternalService();

  Future<void> saveGoogleUserToFirestore(User user) async {
    final docRef =
    FirebaseFirestore.instance.collection('users').doc(user.uid);

    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      await docRef.set({
        "uid": user.uid,
        "name": user.displayName ?? '',
        "email": user.email ?? '',
        "about": "Hello! I'm ${user.displayName ?? ''}",
        "image": user.photoURL ?? '',
        "created_at": DateTime.now().millisecondsSinceEpoch,
        "last_message_time": DateTime.now().millisecondsSinceEpoch,
        "last_activated":
        user.metadata.lastSignInTime?.millisecondsSinceEpoch.toString() ?? '',
        "push_token": '',
        "online": true,
        "my_users": [],
      });
    } else {
      await docRef.update({
        "last_activated":
        user.metadata.lastSignInTime?.millisecondsSinceEpoch.toString() ?? '',
        "online": true,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExternalLoginBloc, ExternalLoginState>(
      listener: (context, state) {
        if (state.status == externalLoginStatus.success) {
          Shared.dismissDialog(context: context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (c) => BlocProvider(
                create: (_) => BottomNavCubit(),
                child: HomeLayoutScreen(),
              ),
            ),
          );
        } else if (state.status == externalLoginStatus.failure) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failureMessage ?? kGoogleSignInFailed.tr())),
          );
        }
      },
      child: Column(
        children: [
          _buildButton(
            context: context,
            provider: 'google',
            text: kContinueWithGoogle.tr(),
            icon: "assets/images/Google.png",
            onTap: () async {
              try {
                Shared.showLoadingDialog(context: context);

                final result = await auth.signInWithGoogle();
                if (result == null) return;

                await saveGoogleUserToFirestore(result.user);

                context.read<ExternalLoginBloc>().add(
                  ExternalLoginEvent(
                    provider: 'google',
                    accessToken: result.accessToken,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(kGoogleSignInFailed.tr())),
                );
              }
            },
          ),
        ],
      ),
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