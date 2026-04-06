import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Features/Authentication/login/data/external_services/auth_external_services.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/external_login_bloc.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/external_login_state.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logo_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart%20%20';

class ExternalLoginWidget extends StatelessWidget {
  ExternalLoginWidget({super.key});

  final auth = AuthExternalService();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocListener<ExternalLoginBloc, ExternalLoginState>(
          listener: (context, state) {
            if (state.status == externalLoginStatus.loading) {
              Shared.showLoadingDialog(context: context);
            } else if (state.status == externalLoginStatus.success) {
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
          child: LogoIcon(
            path: "assets/images/Facebook.png",
            onTap: () async {
              final token = await auth.signInWithFacebookAndGetAccessToken();

              if (token != null) {
                context.read<ExternalLoginBloc>().add(
                  ExternalLoginEvent(provider: 'facebook', accessToken: token),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Facebook sign-in failed")),
                );
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.02),
          child: LogoIcon(
            path: 'assets/images/Apple.png',
            onTap: () {},
            height: 83,
            width: 83,
          ),
        ),
        BlocListener<ExternalLoginBloc, ExternalLoginState>(
          listener: (context, state) {
            if (state.status == externalLoginStatus.loading) {
              Shared.showLoadingDialog(context: context);
            } else if (state.status == externalLoginStatus.success) {
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
          child: LogoIcon(
            path: "assets/images/Google.png",
            onTap: () async {
              final token = await auth.signInWithGoogleAndGetAccessToken();
              if (token != null) {
                print("Token: $token");

                context.read<ExternalLoginBloc>().add(
                  ExternalLoginEvent(provider: 'google', accessToken: token),
                );
              } else {
                print('Sign-in failed');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Google sign-in failed")),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
