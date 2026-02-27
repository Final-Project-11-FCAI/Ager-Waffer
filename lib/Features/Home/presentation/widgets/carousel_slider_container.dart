import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarouselSliderContainer extends StatelessWidget {
  const CarouselSliderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CarouselSlider(
        enableAutoSlider: true,
        unlimitedMode: true,
        slideIndicator: CircularSlideIndicator(indicatorRadius: 0,),
        children: [
          Image.asset(
           'assets/images/slider_image3.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Image.asset(
           'assets/images/slider_image4.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Image.asset(
            'assets/images/slider_image2.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Image.asset(
            'assets/images/slider_image1.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
