import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RentAndFavoriteButton extends StatelessWidget {
  const RentAndFavoriteButton({super.key, required this.product,});
  final ProductData product;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                product.isAvailable == true ? customAnimatedPushNavigation(context, RequestScreen(product: product,)) : null;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: product.isAvailable == true ? kPrimaryColor : kGreyColor,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                "استأجر الان",
                style: font16BlackSemiBold.copyWith(
                  fontSize: 14.sp,
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
          Gap(10.w),
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                product.isAvailable == true ? null : null;
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: product.isAvailable == true ? kWhiteColor : kGreyColor,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                side: BorderSide(color: product.isAvailable == true ? kPrimaryColor.withOpacity(0.5) : kGreyColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                "إضافة للمفضلة",
                style: font16BlackSemiBold.copyWith(
                  fontSize: 13.sp,
                  color: product.isAvailable == true ? kPrimaryColor : kWhiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
