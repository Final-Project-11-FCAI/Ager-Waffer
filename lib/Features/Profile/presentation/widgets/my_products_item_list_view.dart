import 'package:ager_waffer/Base/common/dialogs.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Profile/data/models/my_listings_model.dart';
import 'package:ager_waffer/Features/Profile/presentation/pages/update_product_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MyProductsItemListView extends StatefulWidget {
  final MyListingsData myListings;

  const MyProductsItemListView({super.key, required this.myListings});

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
              child: widget.myListings.itemImages != null &&
                  widget.myListings.itemImages!.isNotEmpty
                  ? CachedNetworkImage(
                imageUrl: widget.myListings.itemImages!.first,
                width: 90.w,
                height: 90.h,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    Image.asset("assets/images/virtual_image.jpg"),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error),
              )
                  : Image.asset(
                "assets/images/virtual_image.jpg",
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
                      Expanded(child: Text(widget.myListings.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: font14BlackBold.copyWith(fontSize: 12.sp))),
                      Text(
                        "${widget.myListings.price}${
                            widget.myListings.rentUnit == kDaily.tr() ?
                            kCurrencyPerDay.tr() :
                            widget.myListings.rentUnit == kWeekly.tr() ?
                            kCurrencyPerWeek.tr() :
                            widget.myListings.rentUnit == kMonthly.tr() ?
                        kCurrencyPerMonth.tr() : ''}",
                        style: font16BlackSemiBold.copyWith(fontSize: 11,),
                      ),
                    ],
                  ),
                  Text(
                    widget.myListings.condition ?? '',
                    style: font16BlackSemiBold.copyWith(color: Color.fromRGBO(85, 85, 85, 0.61), fontSize: 11),
                  ),
                  Gap(5.h),
                  Row(
                    children: [
                      Text(
                        "${widget.myListings.averageRate}",
                        style: font16BlackSemiBold.copyWith(fontSize: 10, color: Color.fromRGBO(151, 151, 151, 1),),
                      ),
                      Gap(5.w),
                      ...List.generate(
                        5,
                            (index) => Icon(
                          Icons.star,
                          size: 14.sp,
                          color: index < widget.myListings.averageRate!.floor() ? Colors.amber : Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  Gap(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      deleteOrEditProductButton(
                          title: kEdit.tr(),
                          icon: 'assets/images/edit_icon.png',
                          onTap: (){
                            customAnimatedPushNavigation(context, UpdateProductScreen(product: widget.myListings,));
                          },
                          textColor: kBlueColor,
                          backgroundColor: kOpacityGreyColor,
                          borderColor: kBlueColor
                      ),
                      Gap(7.w),
                      deleteOrEditProductButton(
                          title: kDelete.tr(),
                          icon: 'assets/images/delete_icon.png',
                          onTap: (){
                            Dialogs.showDialogDeleteProduct(context, productId: widget.myListings.id!);
                          },
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
