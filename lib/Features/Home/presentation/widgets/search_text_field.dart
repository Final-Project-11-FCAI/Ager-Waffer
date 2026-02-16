import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.sp),
          borderSide: BorderSide(color: kPrimaryColor.withOpacity(0.1)),
        ),
        prefixIcon: Icon(Icons.search, color: kLightPrimaryColor),
        hintText: 'ابحث عن منتج للايجار...',
        hintStyle: font20PrimaryMedium.copyWith(
          fontWeight: regular,
          color: Color.fromRGBO(0, 51, 78, 0.74),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 13.sp),
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }
}
