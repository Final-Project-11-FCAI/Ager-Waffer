import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/coustom_textfield.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logo_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: kPrimaryColor,
        title: Container(alignment: Alignment.centerLeft, child: LogoAsText()),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              CoustomTextField(
                icon: Icon(Icons.email_outlined),
                hint: 'البريد الالكتروني',
                label: 'البريد الالكتروني',
              ),
              CoustomTextField(
                icon: Icon(Icons.lock_outline),
                hint: 'كلمة المرور',
                label: 'كلمة المرور',
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: kPrimaryColor,
                    value: isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        isChecked = newValue!;
                      });
                    },
                  ),
                  Text("تذكرني", style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(flex: 1),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'FrogetPassword');
                    },
                    child: Text(
                      'هل نسيت كلمة المرور؟',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                height: 80,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                  ),
                  child: Text(
                    'تسجيل الدخول',
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
            ],
          ),
        ),
      ),
    );
  }
}
