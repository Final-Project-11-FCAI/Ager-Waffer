import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/email_text_field.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/password_text_field.dart';
import 'package:ager_waffer/Features/Chat/data/models/firebase/fire_auth.dart';
import 'package:ager_waffer/Features/Chat/data/models/user_model.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logo_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
          title: Container(
            alignment: Alignment.centerLeft,
            child: LogoAsText(),
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: kBlackColor,
                          radius: Shared.width * 0.14.r,
                        ),
                        Positioned(
                          top: Shared.height * 0.105.h,
                          right: Shared.width * 0.21.w,
                          child: Image.asset('assets/images/add_icon.png'),
                        ),
                      ],
                    ),
                  ),
                ),
                // Gap(10.h),
                Text(
                  'إضافة صورة',
                  style: font16BlackSemiBold.copyWith(fontWeight: medium),
                ),
                Gap(30.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      EmailTextField(
                        emailController: firstNameController,
                        icon: Icon(Icons.account_circle_outlined),
                        label: "الاسم الأول",
                        isName: true,
                      ),
                      Gap(30.h),
                      EmailTextField(
                        emailController: secondNameController,
                        icon: Icon(Icons.account_circle_outlined),
                        label: "الاسم الثاني",
                        isName: true,
                      ),
                      Gap(30.h),
                      EmailTextField(
                        emailController: emailController,
                        icon: Icon(Icons.email_outlined),
                        label: 'البريد الالكتروني',
                      ),
                      Gap(30.h),
                      PasswordTextField(
                        passwordController: passwordController,
                        icon: Icon(Icons.lock_outline),
                        label: 'كلمة المرور',
                      ),
                      Gap(30.h),
                      ButtonApp(
                        onPressed: () async {
                          Shared.showLoadingDialog(context: context);
                          if (formKey.currentState!.validate()) {
                            try {
                              // إنشاء المستخدم في Firebase Auth
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );

                              User? user = userCredential.user;

                              if (user != null) {
                                // تحديث اسم المستخدم
                                if (firstNameController.text.isNotEmpty) {
                                  await user.updateDisplayName(
                                    "${firstNameController.text} ${secondNameController.text}",
                                  );
                                }

                                // 🔥 حفظ المستخدم في Firestore
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .set({
                                      "uid": user.uid,
                                      "name":
                                          "${firstNameController.text} ${secondNameController.text}",
                                      "email": emailController.text,
                                      'about': "Hello! I'm ${firstNameController.text}",
                                      'last_message_time':
                                          DateTime.now().millisecondsSinceEpoch,
                                      'image': '',
                                      "created_at":
                                          DateTime.now().millisecondsSinceEpoch,
                                      'last_activated': user
                                          .metadata
                                          .lastSignInTime!
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      'push_token': '',
                                      'online': false,
                                      'my_users': [],
                                    });
                              }

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (_) => BottomNavCubit(),
                                    child: const HomeLayoutScreen(),
                                  ),
                                ),
                                (route) => false,
                              );
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())),
                              );
                            }
                          }
                          Shared.dismissDialog(context: context);
                        },
                        text: 'إنشاء حساب',
                        color: kPrimaryColor,
                      ),
                      Gap(10.h),
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
                    LogoIcon(path: 'assets/images/Facebook.png', onTap: () {}),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Shared.width * 0.02,
                      ),
                      child: LogoIcon(
                        path: 'assets/images/Apple.png',
                        onTap: () {},
                        height: 83.h,
                        width: 83.w,
                      ),
                    ),
                    LogoIcon(path: "assets/images/Google.png", onTap: () {}),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "  لديك حساب بالفعل ؟",
                        style: TextStyle(
                          color: Color(0xff5588A3),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                              context,
                              'LoginScreen',
                            );
                          },
                      ),
                      TextSpan(
                        text: " تسجيل الدخول",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
