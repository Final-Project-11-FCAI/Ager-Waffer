import 'package:ager_waffer/Base/common/input_validation.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/password_text_field.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/edit_profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kRedColor,
          foregroundColor: kWhiteColor,
          forceMaterialTransparency: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Shared.height * 0.15.h),
              child: Container(
                width: double.infinity,
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
                    padding: EdgeInsets.only(
                      top: Shared.height * 0.1.h,
                      right: Shared.width * 0.04.w,
                      left: Shared.width * 0.025.h,
                      bottom: Shared.width * 0.04.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الاسم الأول',
                          style: font24LightPrimarySemiBold.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        Gap(10.h),
                        EditProfileTextField(
                          controller: firstNameController,
                          icon: Icon(Icons.account_circle_outlined),
                          label: "الاسم الأول",
                          keyboardType: TextInputType.name,
                          isPrefixFound: true,
                        ),
                        Gap(15.h),
                        Text(
                          "الاسم الثاني",
                          style: font24LightPrimarySemiBold.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        Gap(10.h),
                        EditProfileTextField(
                          controller: secondNameController,
                          icon: Icon(Icons.account_circle_outlined),
                          label: "الاسم الثاني",
                          keyboardType: TextInputType.name,
                          isPrefixFound: true,
                        ),
                        Gap(15.h),
                        Text(
                          'رقم الهاتف',
                          style: font24LightPrimarySemiBold.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        Gap(10.h),
                        EditProfileTextField(
                          controller: emailController,
                          keyboardType: TextInputType.number,
                          icon: Icon(Icons.phone),
                          label: 'رقم الهاتف',
                        ),
                        Gap(15.h),
                        Text(
                          'البريد الالكتروني',
                          style: font24LightPrimarySemiBold.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        Gap(10.h),
                        EditProfileTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          icon: Icon(Icons.email_outlined),
                          label: 'البريد الالكتروني',
                        ),
                        Gap(15.h),
                        Text(
                          'كلمة المرور',
                          style: font24LightPrimarySemiBold.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        Gap(10.h),
                        PasswordTextField(
                          passwordController: passwordController,
                          icon: Icon(Icons.lock_outline),
                          label: 'كلمة المرور',
                            validator: (value) {
                              return InputValidation.passwordValidator(value!);
                            }
                        ),
                        Gap(25.h),
                        ButtonApp(
                          onPressed: () {},
                          text: 'حفظ',
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: Shared.width * 0.25.sp,
              left: Shared.width * 0.25.sp,
              top: Shared.height * -0.03.sp,
              child: Image.asset('assets/images/user_profile_image.png'),
            ),
            Positioned(
              right: Shared.width * 0.31.w,
              top: Shared.height * 0.16.h,
              child: GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    print(image.path);
                  }
                },
                child: Image.asset(
                    'assets/images/camera_edit.png',
                    width: Shared.width * 0.1.w,
                    height: Shared.height * 0.05.h,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
