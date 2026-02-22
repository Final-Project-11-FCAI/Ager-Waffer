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
        slideIndicator: CircularSlideIndicator(),
        children: [
          Image.network(
            'https://picsum.photos/400',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Image.network(
            'https://picsum.photos/401',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Image.network(
            'https://picsum.photos/402',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ],
      ),
    );


    //   Container(
    //   width: double.infinity,
    //   height: Shared.height * 0.2,
    //   decoration: BoxDecoration(
    //     color: kPrimaryColor,
    //     borderRadius: BorderRadius.circular(16),
    //   ),
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 16.w),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Image.asset('assets/images/camera.png'),
    //         Gap(20.h),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               'Canon EOS كاميرا',
    //               style: font16BlackSemiBold.copyWith(color: kWhiteColor),
    //             ),
    //             Text(
    //               "الإيجار باليوم",
    //               style: font15BlackRegular.copyWith(
    //                 fontWeight: semiBold,
    //                 color: Color.fromRGBO(255, 255, 255, 0.58),
    //               ),
    //             ),
    //             Gap(20.h),
    //             Row(
    //               children: [
    //                 Text(
    //                   "4.5",
    //                   style: font16BlackSemiBold.copyWith(
    //                     fontSize: 10,
    //                     color: Color.fromRGBO(151, 151, 151, 1),
    //                   ),
    //                 ),
    //                 Gap(5.w),
    //                 ...List.generate(
    //                   5,
    //                   (index) => Icon(
    //                     Icons.star,
    //                     size: 14.sp,
    //                     color: index < 4 ? Colors.amber : Colors.grey.shade300,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
