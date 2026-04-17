import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ager_waffer/Features/Home/data/models/reviews_about_user_model.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OwnerReviewItem extends StatelessWidget {
  const OwnerReviewItem({super.key, required this.reviews,});

  final Data reviews;

  String formatDateSmart(String date) {
    try {
      final now = DateTime.now();
      final parsedDate = DateTime.parse(date);
      final diff = now.difference(parsedDate);

      if (diff.inSeconds < 60) {
        return kMomentsAgo.tr();
      }

      if (diff.inMinutes < 60) {
        return LocalizeAndTranslate.getLanguageCode() == 'ar' ?
        "${kMinutesAgo.tr()} ${diff.inMinutes} دقيقة"
            : "${diff.inMinutes} ${kMinutesAgo.tr()}";
      }

      if (diff.inHours < 24) {
        return LocalizeAndTranslate.getLanguageCode() == 'ar' ?
        "${kHoursAgo.tr()} ${diff.inHours} ساعة"
            : "${diff.inHours} ${kHoursAgo.tr()}";
      }

      if (diff.inDays <= 7) {
        return LocalizeAndTranslate.getLanguageCode() == 'ar' ?
        "${kDaysAgo.tr()} ${diff.inDays} يوم"
            : "${diff.inDays} ${kDaysAgo.tr()}";
      }

      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return kDate.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: kBlackColor.withOpacity(0.2), width: 1.w),
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
                backgroundImage: reviews.authorImageUrl == null ?
                AssetImage('assets/images/virtual_user.jpg')
                : NetworkImage(reviews.authorImageUrl!,),
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
                             reviews.authorName ?? kUserName.tr(),
                            style: font16BlackSemiBold.copyWith(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        Text(
                          formatDateSmart(reviews.createAt!) ?? kDate.tr(),
                          style: font14GreyRegular.copyWith(fontSize: 11.sp),
                        ),
                      ],
                    ),
                    Gap(4.h),
                    Row(
                      children: [
                        Text(
                          reviews.rate.toString() ??'0.0',
                          style: font20PrimaryMedium.copyWith(
                            fontSize: 12.sp,
                            color: kPartGreyColor,
                          ),
                        ),
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
           reviews.reviewText ??kReviewText.tr(),
            style: font14GreyRegular.copyWith(
              fontSize: 12.sp,
              color: kBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
