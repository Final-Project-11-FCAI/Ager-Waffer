import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/product_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProductCardListView extends StatefulWidget {
  final ProductData product;

  const ProductCardListView({super.key, required this.product});

  @override
  State<ProductCardListView> createState() => _ProductCardListViewState();
}

class _ProductCardListViewState extends State<ProductCardListView> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromRGBO(110, 122, 135, 1)),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: LocalizeAndTranslate.getLanguageCode() == 'en'
                        ? 0
                        : 12.sp,
                    left: LocalizeAndTranslate.getLanguageCode() == 'en'
                        ? 12.sp
                        : 0,
                  ),
                  child:
                      widget.product.itemImages != null &&
                          widget.product.itemImages!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: widget.product.itemImages!.first,
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? kRedColor : kGreyColor,
                  ),
                ),
              ],
            ),
          ),
          Gap(10.w),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name!,
                          style: font16BlackSemiBold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Gap(8.w),
                      Text(
                        "${widget.product.price} ج/${widget.product.rentUnit}",
                        style: font16BlackSemiBold.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                  Text(
                    widget.product.condition!,
                    style: font16BlackSemiBold.copyWith(
                      color: const Color.fromRGBO(85, 85, 85, 0.61),
                    ),
                  ),
                  Gap(5.h),
                  Row(
                    children: [
                      Text(
                        "${widget.product.averageRate}",
                        style: font16BlackSemiBold.copyWith(
                          fontSize: 10,
                          color: const Color.fromRGBO(151, 151, 151, 1),
                        ),
                      ),
                      Gap(5.w),
                      ...List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 14.sp,
                          color: index < widget.product.averageRate!.floor()
                              ? Colors.amber
                              : Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: SizedBox(
                      width: 74.w,
                      height: 31.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.sp),
                          ),
                        ),
                        onPressed: () {
                          customAnimatedPushNavigation(
                            context,
                            ProductDetailsScreen(product: widget.product),
                          );
                        },
                        child: Text(
                          "عرض",
                          style: font16BlackSemiBold.copyWith(
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
