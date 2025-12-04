import 'package:flutter/material.dart';

class Emailwidget extends StatelessWidget {
  const Emailwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hint: Text(
            'البريد الالكتروني',
            style: TextStyle(color: Colors.grey[400]),
          ),
          label: Text('البريد الالكتروني'),

          suffixIcon: Icon(Icons.email_outlined),
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
