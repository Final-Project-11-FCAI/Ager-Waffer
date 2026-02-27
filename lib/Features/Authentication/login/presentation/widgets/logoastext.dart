import 'package:flutter/material.dart';

class LogoAsText extends StatelessWidget {
  const LogoAsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "AJAR",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: " & ",
            style: TextStyle(
              color: Color(0xFFFFC107),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "WAFAR",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
