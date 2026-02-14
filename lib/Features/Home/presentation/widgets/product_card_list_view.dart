import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductCardListView extends StatelessWidget {
  final ProductModel product;

  const ProductCardListView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Icon(
               Icons.favorite_border,
               color: Colors.grey,
             ),
             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                   flex: 1,
                   child: Image.asset(
                     product.image,
                     width: 90,
                     height: 90,
                     fit: BoxFit.contain,
                   ),
                 ),
                 Gap(16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title,
                      style: font16BlackSemiBold
                    ),
                    // Gap(28.sp),
                    Text(
                      product.price,
                      style: font16BlackSemiBold.copyWith(fontSize: 11, fontWeight: bold),
                    )
                  ],
                ),
                Text(
                  product.subtitle,
                  style: font16BlackSemiBold.copyWith(color: Color.fromRGBO(85, 85, 85, 0.61)),
                ),
                Row(
                  children: [
                    Text("${product.rating}",
                    style: font16BlackSemiBold.copyWith(fontSize: 10, color: Color.fromRGBO(151, 151, 151, 1)),
                    ),
                    Gap(5),
                    ...List.generate(
                      5,
                          (index) => Icon(
                        Icons.star,
                        size: 14,
                        color: index < product.rating.floor()
                            ? Colors.amber
                            : Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
                 ],
               ),
          )
           ],
         )
        // Row(
        //   children: [
        //     /// Image
        //     Image.asset(
        //       product.image,
        //       width: 90,
        //       height: 90,
        //       fit: BoxFit.contain,
        //     ),
        //
        //     const SizedBox(width: 16),
        //
        //     /// Text Section
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           /// Title
        //           Text(
        //             product.title,
        //             style: const TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //
        //           const SizedBox(height: 4),
        //
        //           /// Subtitle
        //           Text(
        //             product.subtitle,
        //             style: const TextStyle(
        //               fontSize: 16,
        //               color: Colors.grey,
        //             ),
        //           ),
        //
        //           const SizedBox(height: 8),
        //
        //           /// Rating
        //           Row(
        //             children: [
        //               ...List.generate(
        //                 5,
        //                     (index) => Icon(
        //                   Icons.star,
        //                   size: 18,
        //                   color: index < product.rating.floor()
        //                       ? Colors.amber
        //                       : Colors.grey.shade300,
        //                 ),
        //               ),
        //               const SizedBox(width: 6),
        //               Text("${product.rating}"),
        //             ],
        //           ),
        //
        //           const SizedBox(height: 10),
        //
        //           /// Price + Button
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text(
        //                 product.price,
        //                 style: const TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //               ElevatedButton(
        //                 style: ElevatedButton.styleFrom(
        //                   backgroundColor: const Color(0xFF00334E),
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(30),
        //                   ),
        //                 ),
        //                 onPressed: () {},
        //                 child: const Text("عرض"),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //
        //     /// Favorite Icon
        //     Icon(
        //       Icons.favorite_border,
        //       color: Colors.grey,
        //     ),
        //   ],
        // ),
        ]
      )
    )
    );
  }
}
