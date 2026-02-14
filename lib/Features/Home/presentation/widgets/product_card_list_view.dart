import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProductCardListView extends StatefulWidget {
  final ProductEntity product;

  ProductCardListView({super.key, required this.product});

  @override
  State<ProductCardListView> createState() => _ProductCardListViewState();
}

class _ProductCardListViewState extends State<ProductCardListView> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8,),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color.fromRGBO(110, 122, 135, 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
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
           Gap(16.w),
                 Expanded(
                   flex: 2,
                   child: Padding(
                     padding: EdgeInsets.only(top: 8.h,),
                     child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     widget.product.title,
                                     style: font16BlackSemiBold
                                   ),
                                   Text(
                                     widget.product.price,
                                     style: font16BlackSemiBold.copyWith(fontSize: 11, fontWeight: bold),
                                   )
                                 ],
                               ),
                               Text(
                                 widget.product.subtitle,
                                 style: font16BlackSemiBold.copyWith(color: Color.fromRGBO(85, 85, 85, 0.61)),
                               ),
                               Gap(5.h),
                               Row(
                                 children: [
                                   Text("${widget.product.rating}",
                                   style: font16BlackSemiBold.copyWith(fontSize: 10, color: Color.fromRGBO(151, 151, 151, 1)),
                                   ),
                                   Gap(5.w),
                                   ...List.generate(
                                     5,
                      (index) => Icon(
                                       Icons.star,
                                       size: 14.sp,
                                       color: index < widget.product.rating.floor()
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
                                     onPressed: () {},
                                     child: Text("عرض",style: font16BlackSemiBold.copyWith(color: kWhiteColor),),
                                   ),
                                 ),
                               )
                                ],
                              ),
                   ),
                 )
                  ],
                )
        );
  }
}
