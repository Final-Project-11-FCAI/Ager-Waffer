import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gap/gap.dart';

class ProductDataContainer extends StatelessWidget {
  const ProductDataContainer({super.key, required this.product});

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
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
                    product.name!,
                    overflow: TextOverflow.ellipsis,
                    style: font24PrimarySemiBold.copyWith(
                      fontSize: 20.sp,
                      color: isDark ? kWhiteColor : kBlackColor,
                    ),
                  ),
                  Gap(8.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.averageRate!.toStringAsFixed(1),
                        style: font16BlackSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: isDark ? kTextColor : kGreyColor,
                        ),
                      ),
                      Gap(4.w),
                      ...List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 16.sp,
                          color: index < product.averageRate!.floor()
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
                          text: '${kCondition.tr()} : ',
                          style: font16BlackSemiBold.copyWith(
                            fontWeight: bold,
                            color: isDark ? kWhiteColor : kBlackColor,
                          ),
                        ),
                        TextSpan(
                          text: product.condition!,
                          style: font16BlackSemiBold.copyWith(
                            fontWeight: bold,
                            color: isDark ? kButtonColor : kBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(4.h),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${kCityName.tr()} : ',
                          style: font16BlackSemiBold.copyWith(
                            color: isDark ? kWhiteColor : kBlackColor,
                          ),
                        ),
                        TextSpan(
                          text: "سوهاج",
                          style: font14GreyRegular.copyWith(
                            fontWeight: medium,
                            color: isDark ? kTextColor : kgreyColor,
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
                  product.price.toString(),
                  style: font16BlackSemiBold.copyWith(
                    color: isDark ? kButtonColor : kPrimaryColor,
                    fontSize: 14.sp,
                  ),
                ),
                Gap(6.h),
                Text(
                  "${kInsuranceOnly.tr()}: ${product.insurance} ${'currency'.tr()}",
                  textAlign: TextAlign.center,
                  style: font20PrimaryMedium.copyWith(
                    color: isDark ? kTextColor : kMoreGreyColor,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(16.h),
        Text(
          kDescription.tr(),
          style: font16BlackSemiBold.copyWith(
            color: isDark ? kWhiteColor : kBlackColor,
          ),
        ),
        Gap(8.h),
        Text(
          product.description!,
          style: font14GreyRegular.copyWith(
            fontWeight: medium,
            color: isDark ? kTextColor : kgreyColor,
          ),
        ),
      ],
    );
  }
}
