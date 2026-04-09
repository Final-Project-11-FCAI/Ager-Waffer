import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Orders/domain/entities/finished_orders_entity.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/add_review_bloc.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/add_review_state.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/my_orders_bloc.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/my_orders_state.dart';
import 'package:ager_waffer/Features/Orders/presentation/widgets/rating_bottom_sheet.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gap/gap.dart';

class FinishedOrders extends StatefulWidget {
  const FinishedOrders({super.key});

  @override
  State<FinishedOrders> createState() => _FinishedOrdersState();
}

class _FinishedOrdersState extends State<FinishedOrders> {
  @override
  void initState() {
    super.initState();
    context.read<MyOrdersBloc>().add(GetMyOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddReviewBloc, AddReviewState>(
      listener: (context, state) {
        if (state.status == addReviewStatus.loading) {
          Shared.showLoadingDialog(context: context);
        } else if (state.status == addReviewStatus.success) {
          Shared.dismissDialog(context: context);
          Navigator.of(context).pop();
        } else if (state.status == addReviewStatus.failure) {
          Shared.dismissDialog(context: context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failureMessage ?? kSomethingWentWrong.tr()),
            ),
          );
        }
      },
      child: BlocBuilder<MyOrdersBloc, MyOrdersState>(
        builder: (context, state) {
          if (state.status == myOrdersStatus.loading) {
            return const LoadingPlaceHolder(
              shimmerType: ShimmerType.list,
              cellShimmerHeight: 50,
              shimmerCount: 10,
            );
          } else if (state.status == myOrdersStatus.success) {
            final orders = state.orders;
            final completedOrders = orders
                .where((e) => e.status == "Completed")
                .toList();

            if (completedOrders.isEmpty) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: EmptyProducts(
                          image: 'assets/images/no_products.png',
                          title: 'لا توجد منتجات سابقة',
                          subTitle: 'لم يتم العثور على اي منتجات سابقةً',
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return ListView.builder(
              itemCount: completedOrders.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Shared.width * 0.04.w,
                    vertical: Shared.height * 0.015.h,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: kBlackColor.withOpacity(0.2),
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Shared.width * 0.04.w,
                            vertical: Shared.height * 0.02.h,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                completedOrders[index].itemImages!.first,
                                width: 90.w,
                                height: 90.h,
                                fit: BoxFit.contain,
                              ),
                              Gap(20.h),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    completedOrders[index].itemName ?? '',
                                    style: font16BlackSemiBold.copyWith(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  Gap(2.w),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/owner.png'),
                                      Gap(5.w),
                                      Text(
                                        "المالك: ${completedOrders[index].ownerName ?? ''}",
                                        style: font13kLightPrimaryColorMedium
                                            .copyWith(color: kBlackColor),
                                      ),
                                    ],
                                  ),
                                  Gap(5.w),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/date_determine.png',
                                      ),
                                      Gap(5.w),
                                      Text(
                                        '${completedOrders[index].fromDate!} - ${completedOrders[index].toDate!}',
                                        style: font20PrimaryMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: kTextGreyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gap(10),
                        Divider(
                          height: 1,
                          thickness: 0.7,
                          color: kBlackColor.withOpacity(0.19),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Shared.width * 0.04.w,
                            vertical: Shared.height * 0.02.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'إجمالي المبلغ',
                                style: font13kLightPrimaryColorMedium.copyWith(
                                  color: kDarkGreyColor,
                                ),
                              ),
                              Text(
                                completedOrders[index].totalPrice.toString(),
                                style: font24LightPrimarySemiBold.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Shared.width * 0.1.w,
                          ),
                          child: Divider(
                            height: 1,
                            thickness: 0.5,
                            color: kBlackColor.withOpacity(0.19),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Shared.width * 0.04.w,
                            vertical: Shared.height * 0.02.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              orderButton(
                                text: 'تقييم المنتج',
                                icon: 'assets/images/star.png',
                                backgroundColor: kLightPrimaryColor,
                                textColor: kWhiteColor,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return FractionallySizedBox(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.r),
                                          ),
                                          child: RatingBottomSheet(
                                            reviewType: 'المنتج',
                                            hint: 'المنتج',
                                            completedOrders: completedOrders,
                                            index: index,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              orderButton(
                                text: 'تقييم المالك',
                                icon: 'assets/images/star.png',
                                backgroundColor: kWhiteColor,
                                textColor: kPrimaryColor,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return FractionallySizedBox(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.r),
                                          ),
                                          child: RatingBottomSheet(
                                            reviewType: 'المالك',
                                            hint: 'التعامل',
                                            completedOrders: completedOrders,
                                            index: index,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state.status == myOrdersStatus.failure) {
            return Center(child: Text(state.failureMessage));
          } else {
            return Center(child: Text("No Data Yet"));
          }
        },
      ),
    );
  }

  GestureDetector orderButton({
    required String text,
    required String icon,
    required Color backgroundColor,
    required Color textColor,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Shared.width * 0.41.w,
        height: Shared.height * 0.065.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: kLightPrimaryColor, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 20.w, height: 20.h),
            Gap(5),
            Text(
              text,
              style: font13kLightPrimaryColorMedium.copyWith(
                fontSize: 15.sp,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
