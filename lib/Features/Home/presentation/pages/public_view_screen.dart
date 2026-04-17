import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/reviews_about_user_bloc.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/reviews_about_user_state.dart';
import 'package:ager_waffer/Features/Home/presentation/widgets/owner_review_item.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/custom_error_widget.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../Base/common/theme.dart';

class PublicViewScreen extends StatefulWidget {
  const PublicViewScreen({super.key, required this.product});

  final ProductData product;

  @override
  State<PublicViewScreen> createState() => _PublicViewScreenState();
}

class _PublicViewScreenState extends State<PublicViewScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ReviewsAboutUserBloc>().add(
        GetReviewsAboutUserEvent(userId: widget.product.ownerId!));
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(parsedDate);
  }
  String formatDateArabic(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd MMMM yyyy', 'ar').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhiteColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Shared.height * 0.15.h),
              child: Container(
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
                    padding: EdgeInsets.only(
                      right: Shared.width * 0.04.w,
                      left: Shared.width * 0.04.w,
                      top: Shared.height * 0.07.h,
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.product.ownerName!,
                          style: font24PrimarySemiBold.copyWith(color: kBlackColor),
                        ),
                        Text(
                          widget.product.ownerEmail!,
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
                          kGovernorate.tr(),
                          widget.product.governorate ?? "",
                        ),
                        _buildInfoRow(
                          Icons.calendar_month_outlined,
                          kJoinDate.tr(),
                          "${kMemberSince.tr()} ${
                              LocalizeAndTranslate.getLanguageCode() == 'ar' ?
                              formatDateArabic(widget.product.ownerCreatedAt!) ?? '2026'
                          : formatDate(widget.product.ownerCreatedAt!) ?? '2026'}",
                        ),
                        Gap(10.h),
                        BlocBuilder<ReviewsAboutUserBloc, ReviewsAboutUserState>(
                          builder: (context, state) {
                            if (state.status == reviewsAboutUserStatus.loading) {
                              return const LoadingPlaceHolder(
                                shimmerType: ShimmerType.list,
                                cellShimmerHeight: 50,
                                shimmerCount: 10,
                              );
                            } else if (state.status == reviewsAboutUserStatus.success) {
                              final reviews = state.reviews;
                              return reviews.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: reviews.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8.h),
                                          child: OwnerReviewItem(
                                            reviews: reviews[index],
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
                            } else if (state.status == reviewsAboutUserStatus.failure) {
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: Shared.height * 0.3,
                                    child: Center(
                                      child: CustomErrorWidget(
                                        message: state.failureMessage,
                                        onRetry: () {
                                          context.read<ReviewsAboutUserBloc>().add(
                                              GetReviewsAboutUserEvent(userId: widget.product.ownerId!),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );

                            } else  {
                              return Center(child: Text(kNoDataYet.tr()));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      Positioned(
        right: Shared.width * 0.25.sp,
        left: Shared.width * 0.25.sp,
        top: Shared.height * 0.02.sp,
        child: CircleAvatar(
          radius: 70.r,
          backgroundColor: kWhiteColor,
          child: CircleAvatar(
            radius: 65.r,
            backgroundImage: widget.product.ownerPictureUrl == null
                ? AssetImage('assets/images/virtual_user.jpg')
                : NetworkImage(widget.product.ownerPictureUrl!),
          ),
        ),
      )
          ],
        ),
      ),
    );
  }



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
                  Gap(5.h),
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
}


