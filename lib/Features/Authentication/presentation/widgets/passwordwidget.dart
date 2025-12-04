import 'package:flutter/material.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
    
          hint: Text(
            'كلمة المرور',
            style: TextStyle(color: Colors.grey[400]),
          ),
          label: Text('كلمة المرور'),
          
          suffixIcon: Icon(Icons.lock_outline),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          contentPadding: EdgeInsets.all(24),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
