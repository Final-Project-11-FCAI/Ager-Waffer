import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CarouselSliderContainer extends StatelessWidget {
  const CarouselSliderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.r),
      child: CarouselSlider(
        enableAutoSlider: true,
        unlimitedMode: true,
        slideIndicator: CircularSlideIndicator(indicatorRadius: 0,),
        children: [
          Image.asset(
            LocalizeAndTranslate.getLanguageCode() == 'en' ?
            'assets/images/En_slider_image3.png' :
            'assets/images/slider_image3.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Image.asset(
            LocalizeAndTranslate.getLanguageCode() == 'en' ?
            'assets/images/En_slider_image4.png' :
           'assets/images/slider_image4.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Image.asset(
            LocalizeAndTranslate.getLanguageCode() == 'en' ?
            'assets/images/En_slider_image2.png' :
            'assets/images/slider_image2.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Image.asset(
            LocalizeAndTranslate.getLanguageCode() == 'en' ?
            'assets/images/En_slider_image1.png' :
            'assets/images/slider_image1.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
