import 'package:flutter/material.dart';

class CoustomTextField extends StatelessWidget {
  const CoustomTextField({
    super.key,
    required this.icon,
    required this.hint,
    required this.label,
  });
  final Icon icon;
  final String hint;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hint: Text(hint, style: TextStyle(color: Colors.grey[400])),
          label: Text(label),

          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          contentPadding: EdgeInsets.all(24),
          floatingLabelStyle: TextStyle(color: Colors.blue[200]),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
