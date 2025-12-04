import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/presentation/pages/login_screen.dart';
import 'package:ager_waffer/Features/Authentication/presentation/widgets/emailwidget.dart';
import 'package:ager_waffer/Features/Authentication/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Authentication/presentation/widgets/namewidget.dart';
import 'package:ager_waffer/Features/Authentication/presentation/widgets/passwordwidget.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logoicons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: kPrimaryColor,
          title: Logoastext(),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              NameWidget(),
              Emailwidget(),
              PasswordWidget(),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                height: 80,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                  ),
                  child: Text(
                    'إنشاء حساب',
                    style: TextStyle(
                      color: kWhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: kLightBlackColor,
                      endIndent: 20,
                      indent: 50,
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
                      thickness: 2,
                      color: kLightBlackColor,
                      indent: 20,
                      endIndent: 50,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoIcon(path: "assets/images/Google.png", onTap: () {}),
                  SizedBox(width: 50),
                  LogoIcon(
                    path: 'assets/images/Apple.png',
                    onTap: () {},
                    height: 83,
                    width: 83,
                  ),
                  SizedBox(width: 50),
                  LogoIcon(path: 'assets/images/Facebook.png', onTap: () {}),
                ],
              ),
              SizedBox(height: 20),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
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
    );
  }
}
