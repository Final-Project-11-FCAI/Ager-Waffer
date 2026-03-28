import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    super.key,
    required this.icon,
    required this.label,
    this.isName = false, required this.emailController, required this.validator,
  });
  final Icon icon;
  final String label;
  final bool isName;
  final TextEditingController emailController;
  final String? Function(String?)? validator;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {

  String? validationError;

  void validateInput() {
    // Run the validator to get the validation result
    final result = widget.validator!(widget.emailController.text);
    setState(() {
      validationError = result; // Set the validation error message
    });
  }

  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(validateInput); // Listen to changes in the text field
  }

  @override
  void dispose() {
    widget.emailController.removeListener(validateInput); // Remove listener on dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.emailController,
          validator: (value) => value!.isEmpty ? kRequired.tr() : null,
          keyboardType: widget.isName ? TextInputType.name : TextInputType.emailAddress,
          decoration: InputDecoration(
            label: Text(widget.label),
            prefixIcon: widget.icon,
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
