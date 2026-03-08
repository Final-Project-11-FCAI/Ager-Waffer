import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.isPrefixFound = false,
    required this.keyboardType, this.initialText,
  });

  final Icon icon;
  final String label;
  final bool isPrefixFound;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? initialText;

  @override
  Widget build(BuildContext context) {
    // put received text inside the controller
    if (initialText != null && controller.text.isEmpty) {
      controller.text = initialText!;
    }

    return TextFormField(
      controller: controller,
      validator: (value) => value!.isEmpty ? "Requird" : null,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: isPrefixFound ? null : icon,
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
