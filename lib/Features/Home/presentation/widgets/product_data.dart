import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gap/gap.dart';

class ProductDataContainer extends StatelessWidget {
  const ProductDataContainer({super.key, required this.product});

  final ProductData product;

  String rentCondition() {
    return product.condition == "BrandNew" ||
        product.condition == "أول استخدام"
        ? kBrandNew.tr()
        : product.condition == "New" ||
        product.condition == "جديد"
        ? kNew.tr()
        : product.condition == "Used" ||
        product.condition == "مستخدم"
        ? kUsed.tr()
        : product.condition == "HeavilyUsed" ||
        product.condition == "مستخدم بشدة"
        ? kHeavilyUsed.tr()
        : '';
  }

  String categoryType() {
    return product.categoryName == "Electronics" ||
        product.categoryName == "إلكترونيات"
        ? kElectronics.tr()
        : product.categoryName == "Home Appliances" ||
        product.categoryName == "أجهزة منزلية"
        ? kHomeAppliances.tr()
        : product.categoryName == "Baby Gear" ||
        product.categoryName == "مستلزمات أطفال"
        ? kBabyGear.tr()
        : product.categoryName == "Books" ||
        product.categoryName == "كتب"
        ? kBooks.tr()
        : product.categoryName == "Travel Gear" ||
        product.categoryName == "معدات سفر"
        ? kTravelGear.tr()
        : '';
  }

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
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
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
                          color: isDark ? kWhiteColor : kGreyColor,
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
                          style: font16BlackSemiBold.copyWith(fontWeight: bold,color: isDark ? kWhiteColor : kBlackColor,),
                        ),
                        TextSpan(
                          text: rentCondition(),
                          style: font16BlackSemiBold.copyWith(
                            fontWeight: bold,
                            color: kButtonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${kCategory.tr()} : ',
                          style: font16BlackSemiBold.copyWith(fontWeight: bold,color: isDark ? kWhiteColor : kBlackColor,),
                        ),
                        TextSpan(
                          text: categoryType(),
                          style: font16BlackSemiBold.copyWith(
                            fontWeight: bold,
                            color: kButtonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${kCity.tr()} : ',
                          style: font16BlackSemiBold.copyWith(fontWeight: bold,color: isDark ? kWhiteColor : kBlackColor,),
                        ),
                        TextSpan(
                          text: product.governorate!,
                          style: font16BlackSemiBold.copyWith(
                            fontWeight: bold,
                            color: kButtonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${kAvailability.tr()} : ',
                          style: font16BlackSemiBold.copyWith(fontWeight: bold,color: isDark ? kWhiteColor : kBlackColor,),
                        ),
                        TextSpan(
                          text: product.isAvailable! ? kAvailable.tr() : kNotAvailable.tr(),
                          style: font16BlackSemiBold.copyWith(
                            fontWeight: bold,
                            color: product.isAvailable! ? kGreenColor : kRedColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Gap(10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${product.price.toString()} ${'currency'.tr()}",
                  style: font16BlackSemiBold.copyWith(
                    color: isDark ? kWhiteColor : kPrimaryColor,
                    fontSize: 14.sp,
                  ),
                ),
                Gap(6.h),
                Text(
                  "${kInsuranceOnly.tr()}: ${product.insurance} ${'currency'.tr()}",
                  textAlign: TextAlign.center,
                  style: font20PrimaryMedium.copyWith(
                    color: isDark ? kWhiteColor.withOpacity(0.9) : kMoreGreyColor,
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
          style: font16BlackSemiBold.copyWith(color: isDark ? kWhiteColor : kBlackColor,),
        ),
        Gap(8.h),
        SelectableText(
          product.description!,
          style: font14GreyRegular.copyWith(fontWeight: medium, color: isDark ? kWhiteColor.withOpacity(0.8) : kGreyColor,),
        ),
      ],
    );
  }
}
