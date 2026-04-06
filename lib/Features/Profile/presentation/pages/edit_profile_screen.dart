import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/input_validation.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/pages/login_screen.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/password_text_field.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_profile_bloc.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_profile_state.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/edit_profile_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'dart:io';

import '../../../Authentication/login/data/models/login_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user, this.userData});

  final Data user;
  final Data? userData;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  XFile? _pickedImage;

  String _originalFirstName = '';
  String _originalLastName = '';
  String _originalPhone = '';

  bool get _isPasswordValid {
    if (passwordController.text.isEmpty) return true;

    return InputValidation.passwordValidator(
        passwordController.text) ==
        null;
  }

  bool get _hasChanges =>
      (firstNameController.text != _originalFirstName ||
          secondNameController.text != _originalLastName ||
          phoneController.text != _originalPhone ||
          passwordController.text.isNotEmpty ||
          _pickedImage != null) &&
          _isPasswordValid &&
          _isPhoneValid;

  bool get _isPhoneValid {
    // لو المستخدم ما غيّرش الرقم → اعتبره valid
    if (phoneController.text == _originalPhone) return true;

    // لو فاضي → اعتبره valid (عشان انت بتبعت null)
    if (phoneController.text.isEmpty) return true;

    // لو كتب رقم → لازم يكون valid
    return InputValidation.isValidEditEgyptianPhone(
        phoneController.text) ==
        null;
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    firstNameController.addListener(() => setState(() {}));
    secondNameController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  void loadUser() async {
    final user = await sharedPreferenceManager.getUser();

    if (user != null) {
      setState(() {
        firstNameController.text = user.firstName ?? "";
        secondNameController.text = user.lastName ?? "";
        phoneController.text = widget.userData!.phoneNumber ?? "";
        emailController.text = user.email ?? "";

        _originalFirstName = user.firstName ?? "";
        _originalLastName = user.lastName ?? "";
        _originalPhone = user.phoneNumber ?? "";
      });
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state.status == updateProfileStatus.loading) {
          Shared.showLoadingDialog(context: context);
        } else if (state.status == updateProfileStatus.success) {
          Shared.dismissDialog(context: context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(kUpdateSuccess.tr()),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        } else if (state.status == updateProfileStatus.failure) {
          Shared.dismissDialog(context: context);

          ScaffoldMessenger.of(context).hideCurrentSnackBar(); // مهم

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.failureMessage.isNotEmpty
                    ? state.failureMessage
                    : kUpdateError.tr(),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            backgroundColor: kRedColor,
            foregroundColor: kWhiteColor,
            forceMaterialTransparency: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Stack(
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
                              kFirstName.tr(),
                              style: font24LightPrimarySemiBold.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            Gap(10.h),
                            EditProfileTextField(
                              controller: firstNameController,
                              icon: Icon(Icons.account_circle_outlined),
                              label: kFirstName.tr(),
                              keyboardType: TextInputType.name,
                              isPrefixFound: true,
                            ),
                            Gap(15.h),
                            Text(
                              kLastName.tr(),
                              style: font24LightPrimarySemiBold.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            Gap(10.h),
                            EditProfileTextField(
                              controller: secondNameController,
                              icon: Icon(Icons.account_circle_outlined),
                              label: kLastName.tr(),
                              keyboardType: TextInputType.name,
                              isPrefixFound: true,
                            ),
                            Gap(15.h),
                            Text(
                              kPhone.tr(),
                              style: font24LightPrimarySemiBold.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            Gap(10.h),
                            EditProfileTextField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              icon: Icon(Icons.phone),
                              label: kPhone.tr(),
                              validator: (value) {
                                if (value == _originalPhone || value!.isEmpty) return null;
                                return InputValidation.isValidEditEgyptianPhone(value ?? '');
                                },
                            ),
                            Gap(15.h),
                            Text(
                              kPassword.tr(),
                              style: font24LightPrimarySemiBold.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            Gap(10.h),
                            PasswordTextField(
                              passwordController: passwordController,
                              icon: Icon(Icons.lock_outline),
                              label: kEnterNewPassword.tr(),
                              validator: (value) {
                                return InputValidation.passwordValidator(value!);
                              },
                            ),
                            Gap(25.h),
                            ButtonApp(
                              onPressed: _hasChanges
                                  ? () {
                                      _showUpdateDialog(context);
                                    }
                                  : null,
                              text: kSave.tr(),
                              color: _hasChanges ? kPrimaryColor : kGreyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Profile Image
                Positioned(
                  right: Shared.width * 0.25.sp,
                  left: Shared.width * 0.25.sp,
                  top: Shared.height * 0.02.sp,
                  child: _pickedImage != null
                      ? CircleAvatar(
                          radius: 70.r,
                          backgroundImage: FileImage(File(_pickedImage!.path)),
                        )
                      : CircleAvatar(
                          radius: 70.r,
                          backgroundImage: NetworkImage(
                            widget.user.imageUrl.toString(),
                          ),
                        ),
                ),

                // Camera Edit Button
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
                        setState(() {
                          _pickedImage = image;
                        });
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
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(kConfirmEditTitle.tr(),
            style: font20PrimaryMedium.copyWith(fontWeight: bold),
          ),
          surfaceTintColor: kWhiteColor,
          content: Text(
            kConfirmEditDesc.tr(),
            style: font16BlackSemiBold.copyWith(
              fontWeight: medium,
              color: kMoreGreyColor,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: kWhiteColor,
                foregroundColor: kPrimaryColor,
              ),
              child: Text(kCancel.tr(),
                style: font16BlackSemiBold.copyWith(
                  fontSize: 14.sp,
                  color: kPrimaryColor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<UpdateProfileBloc>().add(
                  UpdateProfileEvent(
                    firstName: firstNameController.text,
                    lastName: secondNameController.text,
                    phone: phoneController.text.isEmpty
                        ? null
                        : phoneController.text,
                    password: passwordController.text.isEmpty
                        ? null
                        : passwordController.text,
                    profileImage: _pickedImage,
                  ),
                );

                Navigator.of(context).pop(); // بس كده
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: kWhiteColor,
              ),
              child: Text(kEdit.tr(), style: font16BlackSemiBold.copyWith(
                fontSize: 14.sp,
                color: kWhiteColor,
              ),),
            ),
          ],
        );
      },
    );
  }
}
