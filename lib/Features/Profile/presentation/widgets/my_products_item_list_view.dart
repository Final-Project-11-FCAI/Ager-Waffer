import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MyProductsItemListView extends StatefulWidget {
  final ProductEntity product;

  const MyProductsItemListView({super.key, required this.product});

  @override
  State<MyProductsItemListView> createState() => _MyProductsItemListViewState();
}

class _MyProductsItemListViewState extends State<MyProductsItemListView> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kOpacityGreyColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                right: LocalizeAndTranslate.getLanguageCode() == 'en' ? 0 : 12.sp,
                left: LocalizeAndTranslate.getLanguageCode() == 'en' ? 12.sp : 0,
              ),
              child: Image.asset(
                widget.product.image,
                width: 90.w,
                height: 90.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Gap(16.w),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.title, style: font14BlackBold.copyWith(fontSize: 12.sp)),
                      Text(
                        widget.product.price,
                        style: font16BlackSemiBold.copyWith(fontSize: 11,),
                      ),
                    ],
                  ),
                  Text(
                    widget.product.subtitle,
                    style: font16BlackSemiBold.copyWith(color: Color.fromRGBO(85, 85, 85, 0.61), fontSize: 11),
                  ),
                  Gap(5.h),
                  Row(
                    children: [
                      Text(
                        "${widget.product.rating}",
                        style: font16BlackSemiBold.copyWith(fontSize: 10, color: Color.fromRGBO(151, 151, 151, 1),),
                      ),
                      Gap(5.w),
                      ...List.generate(
                        5,
                            (index) => Icon(
                          Icons.star,
                          size: 14.sp,
                          color: index < widget.product.rating.floor() ? Colors.amber : Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  Gap(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      deleteOrEditProductButton(
                          title: 'تعديل',
                          icon: 'assets/images/edit_icon.png',
                          onTap: (){},
                          textColor: kBlueColor,
                          backgroundColor: kOpacityGreyColor,
                          borderColor: kBlueColor
                      ),
                      Gap(7.w),
                      deleteOrEditProductButton(
                          title: 'حذف',
                          icon: 'assets/images/delete_icon.png',
                          onTap: (){},
                        textColor: kMoreRedColor,
                        backgroundColor: kMoreRedColor.withOpacity(0.21),
                        borderColor: kBlackColor.withOpacity(0.31)
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  GestureDetector deleteOrEditProductButton({
    required String? title,
    required void Function()? onTap,
    String? icon,
    Color? textColor,
    Color? borderColor,
    Color? backgroundColor
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: borderColor!, width: 1.w)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w, vertical: Shared.height * 0.006.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title.toString(),style: font16BlackSemiBold.copyWith(fontSize: 14.sp, color: textColor),),
              Gap(10.w),
              Image.asset(icon!, width: 20.w, height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }

}
