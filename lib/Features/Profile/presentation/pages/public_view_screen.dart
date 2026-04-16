import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/owner_review_item.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../Base/common/theme.dart';

class PublicViewScreen extends StatelessWidget {
  const PublicViewScreen({super.key, required this.product});

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhiteColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.04.w, vertical: Shared.height * 0.02.h),
            child: Column(
              children: [
                _buildHeader(),
                _buildUserInfo(),
                Gap(10.h),
                ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: OwnerReviewItem(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              height: 100.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
            ),
            Gap(60.h),
          ],
        ),
        Positioned(
          top: 20.h,
          child: CircleAvatar(
            radius: 70.r,
            backgroundColor: kWhiteColor,
            child: CircleAvatar(
              radius: 65.r,
              backgroundImage: product.ownerPictureUrl == null
                  ? AssetImage('assets/images/virtual_user.jpg')
                  : NetworkImage(product.ownerPictureUrl!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Text(
            product.ownerName!,
            style: font24PrimarySemiBold.copyWith(color: kBlackColor),
          ),
          Text(
            product.ownerEmail!,
            style: font24PrimarySemiBold.copyWith(
              color: kGreyColor,
              fontSize: 14,
            ),
          ),
          Gap(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: kMoreYellowColor, size: 18),
              Gap(5.w),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "4.8",
                      style: font14GreyRegular.copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(20.h),
          _buildInfoRow(
            Icons.location_on_outlined,
            "المحافظة",
            product.governorate!,
          ),
          _buildInfoRow(
            Icons.calendar_month_outlined,
            "تاريخ الانضمام",
            "عضو منذ 2024",
          ),
        ],
      ),
    );
  }

  // 3. قائمة التقييمات (Reviews)
  // Widget _buildReviewsList() {
  //   return Padding(
  //     padding: EdgeInsets.all(24.w),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Gap(15.h),
  //         _reviewItem(
  //           "عمرو حسن",
  //           "التعامل كويس جداً وكل حاجة كانت تمام",
  //           "منذ يومين",
  //           4.5,
  //         ),
  //         _reviewItem(
  //           "ندى يونس",
  //           "المنتج كان زي الوصف بالضبط",
  //           "منذ أسبوع",
  //           3.0,
  //         ),
  //         _reviewItem(
  //           "مني علي",
  //           "شخص محترم جداً والتعامل كان سهل",
  //           "منذ أسبوعين",
  //           5.0,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // ويدجت الصفوف الصغيرة في بيانات المستخدم
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kLightPrimaryColor, size: 22),
              Gap(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: font15SomeBlackColorMedium.copyWith(
                      color: kGreyColor,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    value,
                    style: font24PrimarySemiBold.copyWith(fontSize: 15.sp),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ويدجت التقييم الواحد
  // Widget _reviewItem(String name, String comment, String date, double rate) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 15.h),
  //     padding: EdgeInsets.all(12.w),
  //     decoration: BoxDecoration(
  //       color: kWhiteColor,
  //       borderRadius: BorderRadius.circular(15.r),
  //       border: Border.all(color: kOpacityGreyColor),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               date,
  //               style: font15SomeBlackColorMedium.copyWith(
  //                 color: kGreyColor,
  //                 fontSize: 10.sp,
  //               ),
  //             ),
  //             Row(
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(name, style: font14BlackBold),
  //                     Gap(2.h),
  //                     Row(
  //                       children: [
  //                         Text(
  //                           rate.toString(),
  //                           style: font24PrimarySemiBold.copyWith(
  //                             color: kGreyColor,
  //                             fontSize: 12.sp,
  //                           ),
  //                         ),
  //                         const Icon(
  //                           Icons.star,
  //                           color: kMoreYellowColor,
  //                           size: 14,
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 Gap(10.w),
  //                 CircleAvatar(radius: 15.r, backgroundColor: kGreyColor),
  //               ],
  //             ),
  //           ],
  //         ),
  //
  //         Gap(25.h),
  //         Text(comment, style: font14GreyRegular.copyWith(color: kBlackColor)),
  //         Divider(thickness: 1),
  //         Gap(5.h),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             _buildHelpfulAction(Icons.thumb_up_alt_rounded, "مفيد", "8"),
  //             Gap(15.w),
  //             _buildHelpfulAction(
  //               Icons.thumb_down_alt_rounded,
  //               "غير مفيد",
  //               "0",
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

// Widget _buildHelpfulAction(IconData icon, String label, String? count) {
//   return Row(
//     children: [
//       if (count != null)
//         Text("($count) ", style: font14GreyRegular.copyWith(fontSize: 11.sp)),
//       Text(label, style: font14GreyRegular.copyWith(fontSize: 11.sp)),
//       Gap(4.w),
//       Icon(icon, size: 16, color: kGreyColor),
//     ],
//   );
// }
