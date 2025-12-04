import 'package:flutter/material.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.grey,
          hint: Text(
            'الاسم',
            style: TextStyle(color: Colors.grey[400]),
          ),
          label: Text('الاسم'),
          suffixIcon: Icon(Icons.account_circle_outlined),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          floatingLabelStyle: TextStyle(color: Colors.blue[200]),
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