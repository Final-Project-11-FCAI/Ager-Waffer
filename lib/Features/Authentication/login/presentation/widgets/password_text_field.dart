import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.icon,
    required this.label, required this.passwordController, required this.validator,
  });

  final Icon icon;
  final String label;
  final TextEditingController passwordController;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isHidden = true;
  String? validationError;

  void validateInput() {
    // Run the validator to get the validation result
    final result = widget.validator!(widget.passwordController.text);
    setState(() {
      validationError = result; // Set the validation error message
    });
  }

  @override
  void initState() {
    super.initState();
    widget.passwordController.addListener(validateInput); // Listen to changes in the text field
  }

  @override
  void dispose() {
    widget.passwordController.removeListener(validateInput); // Remove listener on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.passwordController,
          validator: (value) => value!.isEmpty ? kRequired.tr() : null,
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
        ),
        if (validationError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0), // Add some spacing
            child: Text(
              validationError!,
              style: TextStyle(
                color: Colors.red, // Change this color as needed
                fontSize: 12,
              ),
            ),
          )

      ],
    );
  }
}