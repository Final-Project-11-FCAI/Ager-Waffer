import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/orders_management_bloc.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/orders_management_state.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/add_review_bloc.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/add_review_state.dart';
import 'package:ager_waffer/Features/Orders/presentation/widgets/rating_bottom_sheet.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gap/gap.dart';

class PreviousOrders extends StatefulWidget {
  const PreviousOrders({super.key});

  @override
  State<PreviousOrders> createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrders> {

  @override
  void initState() {
    super.initState();
    context.read<OrdersManagementBloc>().add(GetOrdersManagementEvent());
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
              content: Text(
                state.failureMessage ?? kSomethingWentWrong.tr(),
              ),
            ),
          );
        }
      },
      child: BlocBuilder<OrdersManagementBloc, OrdersManagementState>(
        builder: (context, state) {
          if (state.status == ordersManagementStatus.loading) {
            return const LoadingPlaceHolder(
              shimmerType: ShimmerType.list,
              cellShimmerHeight: 50,
              shimmerCount: 10,
            );
          } else if (state.status == ordersManagementStatus.success){
            final ordersManagement = state.ordersManagement;
            final previousOrders = ordersManagement.where((e) => e.status == "Completed").toList();

            if(previousOrders.isEmpty) {
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
                          title: 'لا توجد طلبات واردة',
                          subTitle: 'لم يتم العثور على اي طلبات تأًجير',
                        ),
                      ),
                    ),
                  );
                },
              );
            }


            return ListView.builder(
              itemCount: previousOrders.length,
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
                              Image.network(previousOrders[index].itemImages!.first,
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
                                    previousOrders[index].itemName ?? '',
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
                                        "المالك: ${previousOrders[index].renteeName}",
                                        style: font13kLightPrimaryColorMedium.copyWith(
                                          color: kBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(5.w),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/date_determine.png'),
                                      Gap(5.w),
                                      Text(
                                        '${previousOrders[index].fromDate!} - ${previousOrders[index].toDate!}',
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
                                previousOrders[index].totalPrice.toString(),
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
                            text: 'تقييم المستأجر',
                            icon: 'assets/images/star.png',
                            backgroundColor: kLightPrimaryColor,
                            textColor: kWhiteColor,
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  builder: (context){
                                    return FractionallySizedBox(
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(25.r),
                                            ),
                                            child: RatingBottomSheet(
                                              reviewType: 'المستأجر',hint: 'التعامل',
                                              previousOrders: previousOrders,
                                              index: index,
                                            )
                                        ));
                                  }
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
          } else if (state.status == ordersManagementStatus.failure) {
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
    bool isNotIcon = false,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: Shared.height * 0.065.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: kLightPrimaryColor, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isNotIcon ? SizedBox() : Image.asset(icon, width: 20.w, height: 20.h),
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
