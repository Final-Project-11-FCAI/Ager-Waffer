import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Favorite/data/models/all_favorite_items_model.dart';
import 'package:ager_waffer/Features/Favorite/domain/entities/favorite_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FavoriteItemGideView extends StatelessWidget {
  const FavoriteItemGideView({super.key, required this.allFavoriteItems});

  final FavoriteData allFavoriteItems;

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
            height: 160.h,
            decoration: BoxDecoration(
              color: isDark ? kSomeGreyDarkModeColor : kFavoriteColor,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Stack(
              children: [
                Center(child: allFavoriteItems.imageUrls != null ?
                Image.network(allFavoriteItems.imageUrls!.first)
              : Image.asset('assets/images/virtual_image.jpg')
          ),
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
                      allFavoriteItems.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: font14BlackBold.copyWith(
                        fontWeight: semiBold,
                        color: isDark ? kWhiteColor : kBlackColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: allFavoriteItems.isAvailable! ? kLightGreenColor : kNotAvailableColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Shared.width * 0.02.w,
                          vertical: Shared.height * 0.003.h,
                        ),
                        child: Text(
                          allFavoriteItems.isAvailable! ? 'متاح' : 'غير متاح',
                          style: font20PrimaryMedium.copyWith(
                            color: allFavoriteItems.isAvailable! ? kGreenColor : kPartGreyColor,
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
                    text: allFavoriteItems.price.toString(),
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
                      allFavoriteItems.averageRate.toString(),
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
