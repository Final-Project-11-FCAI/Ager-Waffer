import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ContactOwnerContainer extends StatelessWidget {
  const ContactOwnerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Shared.width * 0.04.w,
        vertical: Shared.height * 0.03.h,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: kPrimaryColor.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundImage: const AssetImage(
              'assets/images/profile_image.png',
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "أحمد محمد",
                  style: font16BlackSemiBold.copyWith(fontSize: 14.sp),
                ),
                Row(
                  children: [
                    Text(
                      '4.5',
                      style: font20PrimaryMedium.copyWith(fontSize: 15.sp),
                    ),
                    Gap(1.w),
                    Icon(Icons.star, size: 17.sp, color: Colors.amber),
                    Gap(2.w),
                    Text(
                      "(15منتج)",
                      style: font20PrimaryMedium.copyWith(
                        fontSize: 11.sp,
                        color: kPartGreyColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(8.w),
          SizedBox(
            height: 34.h,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                backgroundColor: kBlueColor.withOpacity(0.12),
                side: const BorderSide(color: kLightBlueColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "تواصل مع المالك",
                    style: font16BlackSemiBold.copyWith(
                      fontSize: 12.sp,
                      color: kBlueColor,
                    ),
                  ),
                  Gap(5.w),
                  Image.asset('assets/images/contact_icon.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
