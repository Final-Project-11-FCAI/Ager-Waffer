import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/item_reviews_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ReviewItem extends StatelessWidget {
  final Data review;

  const ReviewItem({super.key,
    required this.review,
  });
  
  String formatDateSmart(String date) {
    try {
      final now = DateTime.now();
      final parsedDate = DateTime.parse(date);
      final diff = now.difference(parsedDate);

      // أقل من دقيقة
      if (diff.inSeconds < 60) {
        return 'منذ لحظات';
      }

      // أقل من ساعة
      if (diff.inMinutes < 60) {
        return 'منذ ${diff.inMinutes} دقيقة';
      }

      // أقل من 24 ساعة
      if (diff.inHours < 24) {
        return 'منذ ${diff.inHours} ساعة';
      }

      // أقل من أسبوع
      if (diff.inDays <= 7) {
        return 'منذ ${diff.inDays} يوم';
      }

      // بعد كده تاريخ عادي
      return DateFormat('dd MMM yyyy', 'ar').format(parsedDate);

    } catch (e) {
      return date;
    }
  }

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
                backgroundImage: NetworkImage(review.authorImageUrl ?? 'assets/images/virtual_user.jpg'),
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
                            review.authorName ?? 'User Name',
                            style: font16BlackSemiBold.copyWith(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        Text(
                          formatDateSmart(review.createAt!) ?? 'date',
                          style: font14GreyRegular.copyWith(
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                    Gap(4.h),
                    Row(
                      children: [
                        Text(review.rate.toString() ?? '0.0', style: font20PrimaryMedium.copyWith(fontSize: 12.sp,color: kPartGreyColor),),
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
            review.reviewText ?? 'Review Text',
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
