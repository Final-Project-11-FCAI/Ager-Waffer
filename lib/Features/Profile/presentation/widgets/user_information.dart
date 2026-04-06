import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/input_validation.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/widgets/email_text_field.dart';
import 'package:ager_waffer/Features/Onboarding/presentation/widgets/button_app.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_address_bloc.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gap/gap.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final govController = TextEditingController();
  final streetController = TextEditingController();

  bool isFormValid = false;
  void validateForm() {
    final isValid =
        phoneController.text.isNotEmpty &&
            cityController.text.isNotEmpty &&
            govController.text.isNotEmpty &&
            streetController.text.isNotEmpty &&
            InputValidation.isValidEgyptianPhone(phoneController.text) == '' &&
            InputValidation.isValidAddress(govController.text, '') == '' &&
            InputValidation.isValidAddress(cityController.text, '') == '' &&
            InputValidation.isValidAddress(streetController.text, '') == '';

    setState(() {
      isFormValid = isValid;
    });
  }

  @override
  void initState() {
    super.initState();

    phoneController.addListener(validateForm);
    cityController.addListener(validateForm);
    govController.addListener(validateForm);
    streetController.addListener(validateForm);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateAddressBloc, UpdateAddressState>(
      listener: (context, state) {
        if (state.status == updateAddressStatus.loading) {
          Shared.showLoadingDialog(context: context);
        } else if (state.status == updateAddressStatus.success) {
          Shared.dismissDialog(context: context);
          Navigator.of(context).pop();
        } else if (state.status == updateAddressStatus.failure) {
          Shared.dismissDialog(context: context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.failureMessage ??
                    kSomethingWentWrong.tr(),
              ),
            ),
          );
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          Navigator.pop(context);
          return false;
        },
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Shared.width * 0.06.w,
                  vertical: Shared.height * 0.04.h,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                      kCompleteDataTitle.tr(),
                        style: font20BoldGreyRegular.copyWith(
                          color: kBlackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(5.h),
                      Text(
                        kCompleteDataDesc.tr(),
                        style: font20PrimaryMedium.copyWith(
                          fontSize: 16,
                          color: kPrimaryColor,
                        ),
                      ),
                      Gap(30.h),
                      EmailTextField(
                        icon: Icon(Icons.phone),
                        label: kPhone.tr(),
                        emailController: phoneController,
                        isPhone: true,
                        validator: (value) {
                          return InputValidation.isValidEgyptianPhone(value ?? '');
                        },
                      ),
                      Gap(20.h),
                      EmailTextField(
                        icon: Icon(Icons.location_on),
                        label: kCity.tr(),
                        isName: true,
                        emailController: govController,
                        validator: (value) {
                          return InputValidation.isValidAddress(value ?? '', kEnterGovernorate.tr(),);
                        },
                      ),
                      Gap(20.h),

                      EmailTextField(
                        icon: Icon(Icons.location_city),
                        label: kGovernorate.tr(),
                        emailController: cityController,
                        isName: true,
                        validator: (value) {
                          return InputValidation.isValidAddress(value ?? '', kEnterCity.tr(),);
                        },
                      ),
                      Gap(20.h),
                      EmailTextField(
                        icon: Icon(Icons.streetview),
                        label: kStreet.tr(),
                        isName: true,
                        emailController: streetController,
                        validator: (value) {
                          return InputValidation.isValidAddress(value ?? '', kEnterStreet.tr(),);
                        },
                      ),
                      Gap(30.h),
                  ButtonApp(
                    onPressed: isFormValid
                        ? () {
                      if (formKey.currentState!.validate()) {
                        context.read<UpdateAddressBloc>().add(UpdateAddressEvent(
                          phoneNumber: phoneController.text,
                          city: cityController.text,
                          governorate: govController.text,
                          street: streetController.text,
                        ));
                      }
                    }
                        : null,
                    text: kSave.tr(),
                    color: kPrimaryColor,
                  ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
