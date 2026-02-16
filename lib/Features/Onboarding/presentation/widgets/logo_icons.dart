import 'package:flutter/material.dart';

class LogoIcon extends StatelessWidget {
  const LogoIcon({super.key, required this.path,this.width = 33 , this.height = 33, required this.onTap});
  final String path;
  final double width ;
  final double height ;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap ,
      child: Image.asset(path, width: width, height: height),
    );
  }
}
