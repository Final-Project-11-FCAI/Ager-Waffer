import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: kOpacityGreyColor,
          ),
          alignment: Alignment.center,
          child: Image.asset(product.image, height: 200.h, fit: BoxFit.contain),
        ),
        Gap(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
                (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: index == 1 ? 20.w : 8.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: index == 1
                    ? kPrimaryColor
                    : kInactiveColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
