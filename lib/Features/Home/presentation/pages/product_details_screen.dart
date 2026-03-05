import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:ager_waffer/Features/Home/domain/entities/review_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/contact_owner_container.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_data.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_images.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/rent_and_favorite_button.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  ProductDetailsScreen({super.key, required this.product});

  final List<ReviewEntity> reviews = [
    ReviewEntity(
      name: "عمرو حسن",
      comment: "عربة ممتازة ومريحة جداً، والتعامل مع المالك كان احترافي.",
      date: "منذ 3 أيام",
      rating: 4.5,
    ),
     ReviewEntity(
      name: "ندي يونس",
      comment: "العربة نظيفة وسهلة الاستخدام، أنصح بها جداً للأمهات.",
      date: "منذ أسبوع",
      rating: 5.0,
    ),
    ReviewEntity(
      name: "مني علي",
      comment: "تجربة جيدة بشكل عام، فقط حجم العربة أكبر مما توقعت.",
      date: "منذ أسبوعين",
      rating: 4.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        foregroundColor: kWhiteColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ProductImages(product: product,),
                      ),
                      Gap(20.h),
                      ProductData(product: product),
                      Gap(10.h),
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: Shared.width * 0.08.w, vertical: Shared.height * 0.02.h),
                       child: Divider(color: kBlackColor, thickness: 1.h,),
                     ),
                      Gap(10.h),
                      ContactOwnerContainer(),
                      Gap(24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "التقييمات",
                            style: font16BlackSemiBold.copyWith(fontWeight: bold),
                          ),
                        ],
                      ),
                      Gap(5.h),
                      ListView.builder(
                        itemCount: reviews.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: ReviewItem(
                            review: reviews[index],
                          ),
                        );
                      },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RentAndFavoriteButton()
          ],
        ),
      ),
    );
  }
}


