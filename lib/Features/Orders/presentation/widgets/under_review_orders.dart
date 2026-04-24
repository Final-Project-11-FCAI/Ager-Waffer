import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/cancel_order_bloc.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/cancel_order_state.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/my_orders_bloc.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/my_orders_state.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/custom_error_widget.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class UnderReviewOrders extends StatefulWidget {
  const UnderReviewOrders({super.key});

  @override
  State<UnderReviewOrders> createState() => _UnderReviewOrdersState();
}

class _UnderReviewOrdersState extends State<UnderReviewOrders> {
  @override
  void initState() {
    super.initState();
    context.read<MyOrdersBloc>().add(GetMyOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CancelOrderBloc, CancelOrderState>(
      listener: (context, state) {
        if (state.status == cancelOrderStatus.loading) {
          Shared.showLoadingDialog(context: context);
        } else if (state.status == cancelOrderStatus.success) {
          Shared.dismissDialog(context: context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(kCancelOrderSuccess.tr()),
              backgroundColor: kGreenColor,
            ),
          );
          context.read<MyOrdersBloc>().add(GetMyOrdersEvent());
        } else if (state.status == cancelOrderStatus.failure) {
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
            final pendingOrders = orders
                .where((e) => e.status == "Pending")
                .toList();

            if (pendingOrders.isEmpty) {
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
                          title: kNoUnderReviewOrders.tr(),
                          subTitle: kNoUnderReviewOrdersDesc.tr(),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return ListView.builder(
              itemCount: pendingOrders.length,
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
                              CachedNetworkImage(
                                imageUrl: pendingOrders[index].itemImages!.first,
                                width: 90.w,
                                height: 90.h,
                                fit: BoxFit.contain,
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/virtual_image.jpg",
                                  fit: BoxFit.contain,
                                ),
                                errorWidget: (context, url, error) {
                                  return Image.asset("assets/images/virtual_image.jpg");
                                },
                              ),
                              Gap(20.h),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pendingOrders[index].itemName ?? '',
                                      overflow: TextOverflow.ellipsis,
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
                                            "${kOwner.tr()}: ${pendingOrders[index].ownerName}",
                                          overflow: TextOverflow.ellipsis,
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
                                          '${pendingOrders[index].fromDate ?? ''} - ${pendingOrders[index].toDate ?? ''}',
                                          overflow: TextOverflow.ellipsis,
                                          style: font20PrimaryMedium.copyWith(
                                            fontSize: 12.sp,
                                            color: kTextGreyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                                kTotalAmount.tr(),
                                style: font13kLightPrimaryColorMedium.copyWith(
                                  color: kDarkGreyColor,
                                ),
                              ),
                              Text(
                                pendingOrders[index].totalPrice.toString(),
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
                          child: orderButton(
                            text: kCancelOrder.tr(),
                            backgroundColor: kWhiteColor,
                            textColor: kPrimaryColor,
                              onTap: () {
                                showCancelDialog(
                                  context: context,
                                  onConfirm: () {
                                    context.read<CancelOrderBloc>().add(
                                      CancelOrderEvent(
                                        orderId: pendingOrders[index].requestId!,
                                      ),
                                    );
                                  },
                                );
                              },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state.status == myOrdersStatus.failure) {
            return CustomErrorWidget(
              message: state.failureMessage,
              onRetry: () {
                context.read<MyOrdersBloc>().add(
                  GetMyOrdersEvent(),
                );
              },
            );
          } else {
            return Center(child: Text(kNoDataYet.tr()));
          }
        },
      ),
    );
  }

  void showCancelDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(kCancelConfirmTitle.tr()),
          content: Text(kCancelConfirmDesc.tr()),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(kBack.tr(),
              style: font15SomeBlackColorMedium.copyWith(color: kBlackColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);

                onConfirm();
              },
              child: Text(kConfirm.tr(),
              style: font15SomeBlackColorMedium.copyWith(color: kWhiteColor),
              ),
            ),
          ],
        );
      },
    );
  }

  GestureDetector orderButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: Shared.height * 0.065.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: kLightPrimaryColor, width: 1.w),
        ),
        child: Center(
          child: Text(
            text,
            style: font13kLightPrimaryColorMedium.copyWith(
              fontSize: 15.sp,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
