import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/item_reviews_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/item_reviews_state.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/contact_owner_container.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/product_images.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/rent_and_favorite_button.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/review_item.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../widgets/product_data.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductData product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ItemReviewBloc>().add(
      GetItemReviewEvent(itemId: widget.product.id!),
    );
  }

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
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: ProductImages(product: widget.product)),
                      Gap(20.h),
                      ProductDataContainer(product: widget.product),
                      Gap(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Shared.width * 0.08.w,
                          vertical: Shared.height * 0.02.h,
                        ),
                        child: Divider(color: kBlackColor, thickness: 1.h),
                      ),
                      Gap(10.h),
                      ContactOwnerContainer(product: widget.product),
                      Gap(24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kReviews.tr(),
                            style: font16BlackSemiBold.copyWith(
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                      Gap(5.h),
                      BlocBuilder<ItemReviewBloc, ItemReviewState>(
                        builder: (context, state) {
                          if (state.status == itemReviewStatus.loading) {
                            return const LoadingPlaceHolder(
                              shimmerType: ShimmerType.list,
                              cellShimmerHeight: 50,
                              shimmerCount: 10,
                            );
                          } else if (state.status == itemReviewStatus.success) {
                            final reviews = state.reviews;
                            return reviews.isNotEmpty
                                ? ListView.builder(
                                    itemCount: reviews.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.h,
                                        ),
                                        child: ReviewItem(
                                          review: reviews[index],
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: EmptyProducts(
                                      image: 'assets/images/empty_products.png',
                                      title: kNoReviewsYet.tr(),
                                      subTitle: '',
                                      titleFontSize: 19.sp,
                                    ),
                                  );
                          } else if (state.status == itemReviewStatus.failure) {
                            return Center(child: Text(state.failureMessage));
                          } else {
                            return Center(child: Text(kNoDataYet.tr()));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RentAndFavoriteButton(product: widget.product),
          ],
        ),
      ),
    );
  }
}
