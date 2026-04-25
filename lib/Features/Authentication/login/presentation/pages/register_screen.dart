import 'dart:io';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Helper/app_state.dart';
import 'package:ager_waffer/Base/common/input_validation.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/domain/entities/register_entity.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/authentication_bloc.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/login_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/email_text_field.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/external_login_widget.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/logoastext.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/password_text_field.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/bottom_nav_cubit.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/home_layout_screen.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/coustom_showdialog.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/logo_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromSource(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  bool isButtonEnabled = false;
  void checkFields() {
    final isValid =
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        InputValidation.isValidEmail(emailController.text) &&
        InputValidation.passwordValidator(passwordController.text) == null;

    setState(() {
      isButtonEnabled = isValid;
    });
  }

  @override
  void initState() {
    super.initState();

    firstNameController.addListener(checkFields);
    lastNameController.addListener(checkFields);
    emailController.addListener(checkFields);
    passwordController.addListener(checkFields);
  }

  @override
  void dispose() {
    firstNameController.removeListener(checkFields);
    lastNameController.removeListener(checkFields);
    emailController.removeListener(checkFields);
    passwordController.removeListener(checkFields);
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: isDark ? kDarkModeColor : kPrimaryColor,
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: isDark ? kDarkModeColor : kPrimaryColor,
          foregroundColor: isDark ? kDarkModeColor : kWhiteColor,
          title: Container(
            alignment: Alignment.centerLeft,
            child: LogoAsText(),
          ),
        ),
        body: BlocListener(
          bloc: authenticationBloc,
          listener: (context, state) {
            if (state is RegisterLoading) {
              Shared.showLoadingDialog(context: context);
            } else if (state is RegisterDoneState) {
              registerUserInFirebase(context);


            } else if (state is RegisterErrorLoadingState) {
              Shared.dismissDialog(context: context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? kSomethingWentWrong.tr()),
                ),
              );
            }
          },
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? kDarkModeColor : kWhiteColor,
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
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text(kCamera.tr()),
                                  onTap: () {
                                    Navigator.pop(context);
                                    pickImageFromSource(ImageSource.camera);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text(kGallery.tr()),
                                  onTap: () {
                                    Navigator.pop(context);
                                    pickImageFromSource(ImageSource.gallery);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: Shared.width * 0.14.r,
                            backgroundColor: kBlackColor,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : null,
                            child: _selectedImage == null
                                ? Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 40,
                                  )
                                : null,
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
                   Gap(5.h),
                  Text(
                    kAddImage.tr(),
                    style: font16BlackSemiBold.copyWith(fontWeight: medium,color: isDark ? kWhiteColor : kBlackColor),
                  ),
                  Gap(30.h),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        EmailTextField(
                          emailController: firstNameController,
                          icon: Icon(Icons.account_circle_outlined),
                          label: kFirstName.tr(),
                          validator: (value) {
                            return InputValidation.isValidName(value!, true);
                          },
                          isName: true,
                        ),
                        Gap(30.h),
                        EmailTextField(
                          emailController: lastNameController,
                          icon: Icon(Icons.account_circle_outlined),
                          label: kLastName.tr(),
                          validator: (value) {
                            return InputValidation.isValidName(value!, false);
                          },
                          isName: true,
                        ),
                        Gap(30.h),
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
                        Gap(30.h),
                        ButtonApp(
                          onPressed: isButtonEnabled
                              ? () async {
                                  if (formKey.currentState!.validate()) {
                                    authenticationBloc.add(
                                      RegisterEvent(
                                        registerEntity: RegisterEntity(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          profileImage: _selectedImage,
                                        ),
                                      ),
                                    );
                                  }
                           }
                              : null,

                          text: kCreateAccount.tr(),
                          color: isDark && !isButtonEnabled ? kGreyColor.withOpacity(0.5) :
                          isDark && isButtonEnabled ?
                          kButtonColor : !isDark && !isButtonEnabled ? kGreyColor.withOpacity(0.35) : kPrimaryColor,
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
                          color: isDark ? kGreyColor : kBlackColor,
                          endIndent: 20,
                          indent: 20,
                        ),
                      ),
                      Text(
                        kOrRegisterWith.tr(),
                        style: TextStyle(
                          color: isDark ? kWhiteColor  : kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: isDark ? kGreyColor : kBlackColor,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Shared.height * 0.03.h),
                    child: ExternalLoginWidget(),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${kHaveAccount.tr()} ',
                          style: TextStyle(
                            color: isDark ? kButtonColor : Color(0xff5588A3),
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
                          text: "${kLogin.tr()} ${know.tr()}",
                          style: TextStyle(
                            color: isDark ? kWhiteColor : kPrimaryColor,
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
                      ],
                    ),
                  ),
                  Gap(10.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void successDialog(BuildContext context) {
    CustomShowDialog.show(
      context: context,
      title: Text(
        kRegisterSuccessTitle.tr(),
        textAlign: TextAlign.center,
        style: font14BlackBold.copyWith(
          fontSize: 24,
          color: kPrimaryColor,
        ),
      ),
      description: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: kWelcomePrefix.tr(),
              style: font20PrimaryMedium.copyWith(fontSize: 16),
            ),
            TextSpan(
              text: kAppName.tr(),
              style: font16BlackSemiBold.copyWith(
                color: kBlueColor,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text:
              kWelcomeDesc.tr(),
              style: font20PrimaryMedium.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
      buttonText: kLoginNowArrow.tr(),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => LoginScreen()),
        );
      },
    );
  }

  Future<void> registerUserInFirebase(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        sharedPreferenceManager.writeData(CachingKey.FIREBASE_USER_ID, user.uid.toString());
        if (firstNameController.text.isNotEmpty) {
          await user.updateDisplayName(
            "${firstNameController.text} ${lastNameController.text}",
          );
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          "uid": user.uid,
          "name": "${firstNameController.text} ${lastNameController.text}",
          "email": emailController.text,
          'about': "Hello! I'm ${firstNameController.text}",
          'last_message_time': DateTime.now().millisecondsSinceEpoch,
         'image': _selectedImage.toString(),
          "created_at": DateTime.now().millisecondsSinceEpoch,
          'last_activated': user.metadata.lastSignInTime?.millisecondsSinceEpoch.toString() ?? '',
          'push_token': '',
          'online': false,
          'my_users': [],
        }).whenComplete(() {
          // Shared.dismissDialog(context: context);
          successDialog(context);
        });

      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  Future<String> uploadImageToStorage(File imageFile, String uid) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child('$uid.jpg');

    await ref.putFile(imageFile);

    return await ref.getDownloadURL();
  }
}
