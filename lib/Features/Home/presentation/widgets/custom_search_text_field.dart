import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    this.onChanged,
  });

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return TextField(
      cursorColor: kPrimaryColor,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: isDark ? kGreyColor : kPrimaryColor),
          borderRadius: BorderRadius.circular(16.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: isDark ? kGreyColor : kPrimaryColor),
          borderRadius: BorderRadius.circular(16.r),
        ),
        hintText: kSearchHint.tr(),
        hintStyle: font15BlackRegular.copyWith(
          fontSize: 18.sp,
          color: isDark ? kGreyColor : Color.fromRGBO(0, 51, 78, 0.74),
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Opacity(
            opacity: 0.8,
            child: Icon(
              Icons.search,
              color: isDark ? kGreyColor : kPrimaryColor,
              size: 26.sp,
            ),
          ),
        ),
      ),
    );
  }}
