import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/presentation/widgets/emailwidget.dart';
import 'package:ager_waffer/Features/Authentication/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Authentication/presentation/widgets/passwordwidget.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          toolbarHeight: 190,
          backgroundColor: kPrimaryColor,
          title: Logoastext(),
          actions: [
            
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: kWhiteColor,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_outlined, color: kWhiteColor),
              ),
            ),
          ],
        ),
        body: Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Emailwidget(),
                  PasswordWidget(),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'هل نسيت كلمة المرور؟',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(flex: 1),

                      Text(
                        "تذكرني",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Checkbox(
                        activeColor: kPrimaryColor,
                        value: isChecked,
                        onChanged: (newValue) {
                          setState(() {
                            isChecked = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
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
                      GestureDetector(
                        child: Image.network(
                          'assets/images/Google.png',
                          width: 33,
                          height: 33,
                        ),
                        onTap: (){},
                      ),
                      SizedBox(width: 50),
                      GestureDetector(
                        child: Image.network(
                          'assets/images/Apple.png',
                          height: 83,
                          width: 83,
                        ),
                        onTap: (){},
                      ),
                      SizedBox(width: 50),
                      GestureDetector(
                        child: Image.network(
                          'assets/images/Facebook.png',
                          height: 33,
                          width: 33,
                        ),
                        onTap: (){  },
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
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
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: " أنشيء حسابًا الأن",
                          style: TextStyle(
                            color: kLightBlackColor,
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
      ),
    );
  }
}
