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
                    color: Colors.white, // أزرق غامق
                    fontSize: 25, // حجم الخط مناسب
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " & ",
                  style: TextStyle(
                    color: Color(0xFFFFC107), // أصفر / ذهبي
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "WAFAR",
                  style: TextStyle(
                    color: Colors.white, // نفس الأزرق
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
  }
}