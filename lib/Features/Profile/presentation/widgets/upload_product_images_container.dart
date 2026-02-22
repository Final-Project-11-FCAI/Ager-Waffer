import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class UploadProductImagesContainer extends StatelessWidget {
  const UploadProductImagesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      // Important for rounded
      radius: const Radius.circular(25),
      // Rounded corner
      dashPattern: const [6, 8],
      // dot spacing
      strokeWidth: 1.4,
      color: kLightPrimaryColor,
      child: Container(
        width: double.infinity,
        height: Shared.height * 0.3.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: kProductDataContainerColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/camera_plus.png',
              width: 50.w,
              height: 50.h,
            ),
            Gap(10.h),
            Text(
              'ارفع صور المنتج',
              style: font16BlackSemiBold.copyWith(fontSize: 15),
            ),
            Gap(4.h),
            Text(
              'يمكنك رفع من 3 إلي 5 صور',
              style: font13kLightPrimaryColorMedium,
            ),
            Gap(10.h),
            SizedBox(
              width: Shared.width * 0.35.w,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: Text(
                  'تحميل الصور',
                  style: font13kLightPrimaryColorMedium.copyWith(
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
