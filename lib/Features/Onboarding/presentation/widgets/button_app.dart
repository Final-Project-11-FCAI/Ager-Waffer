import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonApp extends StatefulWidget {
  const ButtonApp({
    super.key,
    this.currentPage,
    this.controller,
    this.isLanguageScreen = false,
    required this.onPressed,
    required this.text,
    required this.color,
  });


  final int? currentPage;
  final PageController? controller;
  final Function () onPressed;
  final String text;
  final Color color;
  final bool isLanguageScreen;

  @override
  State<ButtonApp> createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp> with SingleTickerProviderStateMixin{

  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );
    _animController.forward();
  }

  @override
  void didUpdateWidget(covariant ButtonApp oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the page changed → restart animation
    if (oldWidget.currentPage != widget.currentPage) {
      _animController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: widget.isLanguageScreen ? Shared.height * 0.02 : Shared.height * 0.015),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Shared.width * 0.07),
                side: BorderSide(color: kPrimaryColor, width: 1),
              ),
              backgroundColor: widget.color,
            ),
            child: Text(
              widget.text,
              style: GoogleFonts.notoSansArabic(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: widget.color == kPrimaryColor ? kWhiteColor : kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
