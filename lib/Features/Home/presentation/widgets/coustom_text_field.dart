import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';

class CoustomTextField extends StatelessWidget {
  final Widget text;
  final IconData icon;
   const CoustomTextField({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        textAlign: TextAlign.right,

        decoration: InputDecoration(
          label: text,
          contentPadding: EdgeInsets.all(36),
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: kWhiteColor,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(26)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
      ),
    );
  }
}
