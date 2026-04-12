import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Base/validator.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/coustom_text_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatelessWidget {
  UserInformation({
    super.key,
    required this.phone,
    required this.governorate,
    required this.city,
    required this.street,
    required this.checkPhone,
    required this.checkGovernorate,
    required this.checkCity,
    required this.checkStreet,
  });
  final formKey = GlobalKey<FormState>();
  String phone;
  String governorate;
  String city;
  String street;
  String? checkPhone;
  String? checkGovernorate;
  String? checkCity;
  String? checkStreet;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// العنوان
              Text(
                "يرجي إستكمال بياناتك أولاً",
                style: font20BoldGreyRegular.copyWith(
                  color: kBlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "لإتمام عملية الإيجار بأمان",
                style: font20PrimaryMedium.copyWith(
                  fontSize: 16,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(height: 30),
              CoustomTextField(
                icon: Icons.phone,
                text: Text(
                  "رقم الهاتف",
                  style: font14GreyRegular.copyWith(fontSize: 16),
                ),
                onFieldSubmitted: (value) => phone = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "هذا الحقل مطلوب";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CoustomTextField(
                icon: Icons.location_on,
                text: Text(
                  "المحافظة",
                  style: font14GreyRegular.copyWith(fontSize: 16),
                ),
                onFieldSubmitted: (value) => governorate = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "هذا الحقل مطلوب";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CoustomTextField(
                icon: Icons.location_city_rounded,
                text: Text(
                  "المدينة",
                  style: font14GreyRegular.copyWith(fontSize: 16),
                ),
                onFieldSubmitted: (value) => city = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "هذا الحقل مطلوب";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CoustomTextField(
                icon: Icons.streetview,
                text: Text(
                  "الشارع",
                  style: font14GreyRegular.copyWith(fontSize: 16),
                ),
                onFieldSubmitted: (value) => street = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "هذا الحقل مطلوب";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              /// زر حفظ
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    } else {}
                  },
                  child: Text(
                    "حفظ",
                    style: font20BoldGreyRegular.copyWith(
                      fontSize: 24,
                      color: kWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
