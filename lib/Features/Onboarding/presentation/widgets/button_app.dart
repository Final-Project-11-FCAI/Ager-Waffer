import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonApp extends StatefulWidget {
  const ButtonApp({
    super.key,
    this.currentPage,
    this.controller,
    this.borderRadius,
    this.isLanguageScreen = false,
    required this.onPressed,
    required this.text,
    required this.color,
    this.isReview = false,
    this.isLogin = false,
  });

  final int? currentPage;
  final PageController? controller;
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final bool isLanguageScreen;
  final bool isReview;
  final bool isLogin;
  final double? borderRadius;

  @override
  State<ButtonApp> createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp>
    with SingleTickerProviderStateMixin {
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
            style:
                ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  foregroundColor:
                      widget.color == kPrimaryColor ||
                          widget.color == kDoneColor
                      ? kWhiteColor
                      : kPrimaryColor,
                  padding: EdgeInsets.symmetric(
                    vertical: widget.isLanguageScreen
                        ? Shared.height * 0.024.h
                        : Shared.height * 0.02.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? Shared.width * 0.07.w,
                    ),
                    side: BorderSide(color: widget.color, width: 1),
                  ),
                ).copyWith(
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return widget.color ;
                    }
                    return widget.color;
                  }),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.notoSansArabic(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: widget.isLogin ? kPrimaryColor : kWhiteColor,
                  ),
                ),
                if (widget.isReview) ...[
                  Gap(10.w),
                  const Icon(Icons.send, color: kWhiteColor, size: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
