import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.icon,
    required this.label,
    this.isName = false,
  });
  final Icon icon;
  final String label;
  final bool isName;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isName ? TextInputType.name : TextInputType.emailAddress,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: icon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),
        contentPadding: EdgeInsets.all(Shared.width * 0.05.w),
        floatingLabelStyle: TextStyle(color: kBorderAuthColor),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide(color: kBorderAuthColor),
        ),
      ),
    );
  }
}
