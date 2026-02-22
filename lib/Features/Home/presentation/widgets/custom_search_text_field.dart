import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          hintText: 'ابحث عن منتج للايجار...',
          hintStyle: font15BlackRegular.copyWith(
            fontSize: 18.sp,
            color: Color.fromRGBO(0, 51, 78, 0.74),
          ),
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Opacity(
                opacity: 0.8,
                child: Icon(Icons.search, color: kPrimaryColor, size: 26.sp,),
              ))),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(16.r));
  }
}
