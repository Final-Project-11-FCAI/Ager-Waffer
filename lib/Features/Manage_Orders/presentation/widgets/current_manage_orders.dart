import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/orders_management_bloc.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/orders_management_state.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CurrentManageOrders extends StatefulWidget {
  const CurrentManageOrders({super.key});

  @override
  State<CurrentManageOrders> createState() => _CurrentManageOrdersState();
}

class _CurrentManageOrdersState extends State<CurrentManageOrders> {

  @override
  void initState() {
    super.initState();
    context.read<OrdersManagementBloc>().add(GetOrdersManagementEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersManagementBloc, OrdersManagementState>(
        builder: (context, state) {
          if (state.status == ordersManagementStatus.loading) {
            return const LoadingPlaceHolder(
              shimmerType: ShimmerType.list,
              cellShimmerHeight: 50,
              shimmerCount: 10,
            );
          } else if (state.status == ordersManagementStatus.success) {
            final ordersManagement = state.ordersManagement;
            final currentOrdersManagement = ordersManagement.where((e) =>
            e.status == "Approved").toList();

            if (currentOrdersManagement.isEmpty) {
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
                          title: 'لا توجد طلبات جارية',
                          subTitle: 'لم يتم العثور على اي طلبات حالية',
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return ListView.builder(
              itemCount: currentOrdersManagement.length,
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
                              currentOrdersManagement[index].itemImages == null ?
                              Image.asset(
                                'assets/images/virtual_image.jpg', width: 90.w,
                                height: 90.h,
                                fit: BoxFit.contain,)
                                  : Image.network(
                                currentOrdersManagement[index].itemImages!.first,
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
                                    currentOrdersManagement[index].itemName ??
                                        '',
                                    style: font16BlackSemiBold.copyWith(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  Gap(2.h),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/owner.png'),
                                      Gap(5.w),
                                      Text(
                                        "المالك: ${currentOrdersManagement[index]
                                            .renteeName}",
                                        style: font13kLightPrimaryColorMedium
                                            .copyWith(
                                          color: kBlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(5.h),
                                  Row(
                                    children: [
                                      Image.asset(
                                          'assets/images/date_determine.png'),
                                      Gap(5.w),
                                      Text(
                                        '${currentOrdersManagement[index]
                                            .fromDate ??
                                            ''} - ${currentOrdersManagement[index]
                                            .toDate ?? ''}',
                                        style: font20PrimaryMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: kTextGreyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(5.h),
                                  Row(
                                    children: [
                                      Image.asset(
                                          'assets/images/remainder.png'),
                                      Gap(5.w),
                                      Text(
                                        ' متبقي ${currentOrdersManagement[index]
                                            .timeLeftInDays.toString() ??
                                            ''} يوم',
                                        style: font20PrimaryMedium.copyWith(
                                          fontSize: 13.sp,
                                          color: kOrangeColor,
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
                                currentOrdersManagement[index].totalPrice
                                    .toString(),
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
                                text: 'عرض التفاصيل',
                                icon: 'assets/images/refresh.png',
                                backgroundColor: kLightPrimaryColor,
                                textColor: kWhiteColor,
                                isNotIcon: true,
                                onTap: () {},
                              ),
                              orderButton(
                                text: 'مراسلة المستأجر',
                                icon: 'assets/images/contact_icon.png',
                                backgroundColor: kWhiteColor,
                                textColor: kPrimaryColor,
                                onTap: () {},
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
          } else if (state.status == ordersManagementStatus.failure) {
            return Center(child: Text(state.failureMessage));
          } else {
            return Center(child: Text("No Data Yet"));
          }
        }
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
            isNotIcon ? SizedBox() : Image.asset(
                icon, color: kPrimaryColor, width: 20.w, height: 20.h),
            Gap(3.w),
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
