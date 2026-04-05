import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileTextField extends StatefulWidget {
  const EditProfileTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.isPrefixFound = false,
    required this.keyboardType, this.initialText, this.validator,
  });

  final Icon icon;
  final String label;
  final bool isPrefixFound;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? initialText;
  final String? Function(String?)? validator;


  @override
  State<EditProfileTextField> createState() => _EditProfileTextFieldState();
}

class _EditProfileTextFieldState extends State<EditProfileTextField> {

  String? validationError;

  void validateInput() {
    if (widget.validator != null) {
      final result = widget.validator!(widget.controller.text);
      setState(() {
        validationError = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(validateInput); // Listen to changes in the text field
  }

  @override
  void dispose() {
    widget.controller.removeListener(validateInput); // Remove listener on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // put received text inside the controller
    if (widget.initialText != null && widget.controller.text.isEmpty) {
      widget.controller.text = widget.initialText!;
    }

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        label: Text(widget.label),
        prefixIcon: widget.isPrefixFound ? null : widget.icon,
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
