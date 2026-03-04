import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductData extends StatelessWidget {
  const ProductData({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: font24PrimarySemiBold.copyWith(
                      fontSize: 20.sp,
                      color: kBlackColor,
                    ),
                  ),
                  Gap(8.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: font16BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: kGreyColor,
                        ),
                      ),
                      Gap(4.w),
                      ...List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 16.sp,
                          color: index < product.rating.floor()
                              ? Colors.amber
                              : Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  Gap(4.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'الحالة : ',
                          style: font16BlackSemiBold.copyWith(fontWeight: bold),
                        ),
                        TextSpan(
                          text: product.subtitle,
                          style: font16BlackSemiBold.copyWith(
                            fontWeight: bold,
                            color: kBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.price,
                  style: font16BlackSemiBold.copyWith(
                    color: kPrimaryColor,
                    fontSize: 14.sp,
                  ),
                ),
                Gap(6.h),
                Text(
                  'التأمين:500ج',
                  textAlign: TextAlign.center,
                  style: font20PrimaryMedium.copyWith(
                    color: kMoreGreyColor,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(16.h),
        Text(
          "الوصف",
          style: font16BlackSemiBold,
        ),
        Gap(8.h),
        Text(
          "عربة أطفال مريحة بخامات قوية، مناسبة للاستخدام اليومي "
              "داخل وخارج المنزل. مزودة بحزام أمان، ومظلة للحماية من الشمس، "
              "مع إمكانية طيها وتخزينها بسهولة بعد الاستخدام.",
          style: font14GreyRegular.copyWith(fontWeight: medium),
        ),
      ],
    );
  }
}
