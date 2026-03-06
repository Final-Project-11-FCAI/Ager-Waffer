import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.icon,
    required this.label, required this.passwordController,
  });

  final Icon icon;
  final String label;
  final TextEditingController passwordController;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      validator: (value) => value!.isEmpty ? "Requird" : null,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isHidden,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey[400]),
        labelText: widget.label,
        prefixIcon: widget.icon,
        suffixIcon: IconButton(
          icon: Icon(
            isHidden ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              isHidden = !isHidden;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide(color: kBorderAuthColor),
        ),

        floatingLabelStyle: TextStyle(color: kBorderAuthColor),
        contentPadding: EdgeInsets.all(Shared.width * 0.05.w),
      ),
    );
  }
}