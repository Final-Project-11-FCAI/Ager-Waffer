import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/review_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReviewItem extends StatelessWidget {
  final ReviewEntity review;

  const ReviewItem({super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: kBlackColor.withOpacity(0.2),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: kOpacityGreyColor,
                backgroundImage: const AssetImage(
                  'assets/images/profile_image.png',
                ),
              ),
              Gap(10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            review.name,
                            style: font16BlackSemiBold.copyWith(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        Text(
                          review.date,
                          style: font14GreyRegular.copyWith(
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                    Gap(4.h),
                    Row(
                      children: [
                        Text('4.5', style: font20PrimaryMedium.copyWith(fontSize: 12.sp,color: kPartGreyColor),),
                        Gap(1.w),
                        Icon(Icons.star, size: 12.sp, color: Colors.amber),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(6.h),
          Text(
            review.comment,
            style: font14GreyRegular.copyWith(
              fontSize: 12.sp,
              color: kBlackColor
            ),
          ),
        ],
      ),
    );
  }
}
