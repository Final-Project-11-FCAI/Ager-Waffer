import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Favorite/domain/entities/favorite_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FavoriteItemGideView extends StatelessWidget {
  const FavoriteItemGideView({super.key, required this.favoriteEntity});

  final FavoriteEntity favoriteEntity;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDark ? kDarkModeColor : kWhiteColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: Shared.height * 0.22.h,
            decoration: BoxDecoration(
              color: isDark ? kSomeGreyDarkModeColor : kFavoriteColor,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Stack(
              children: [
                Center(child: Image.asset(favoriteEntity.image)),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundColor: kWhiteColor,
                    radius: 20.r,
                    child: Icon(Icons.favorite, color: kLightRedColor),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Shared.width * 0.01.w,
              vertical: Shared.height * 0.015.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      favoriteEntity.title,
                      overflow: TextOverflow.ellipsis,
                      style: font14BlackBold.copyWith(
                        fontWeight: semiBold,
                        color: isDark ? kWhiteColor : kBlackColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: favoriteEntity.isAvailable
                            ? kLightGreenColor
                            : kNotAvailableColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Shared.width * 0.02.w,
                          vertical: Shared.height * 0.003.h,
                        ),
                        child: Text(
                          favoriteEntity.isAvailable ? 'متاح' : 'غير متاح',
                          style: font20PrimaryMedium.copyWith(
                            color: favoriteEntity.isAvailable
                                ? kGreenColor
                                : kPartGreyColor,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(5.h),
                RichText(
                  text: TextSpan(
                    text: favoriteEntity.price,
                    style: font16BlackSemiBold.copyWith(
                      fontSize: 13,
                      color: kBlueColor,
                    ),
                    children: [
                      TextSpan(
                        text: '/اليوم',
                        style: font16BlackSemiBold.copyWith(
                          fontSize: 13,
                          color: isDark ? kWhiteColor : kBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      favoriteEntity.rating.toString(),
                      style: font20PrimaryMedium.copyWith(fontSize: 15.sp,color: isDark ? kWhiteColor : kPrimaryColor),
                    ),
                    Gap(3.w),
                    Icon(Icons.star, size: 17.sp, color: Colors.amber),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
