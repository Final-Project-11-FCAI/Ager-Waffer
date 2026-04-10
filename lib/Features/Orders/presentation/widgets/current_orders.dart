import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/my_orders_bloc.dart';
import 'package:ager_waffer/Features/Orders/presentation/manager/my_orders_state.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({super.key});

  @override
  State<CurrentOrders> createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {

  @override
  void initState() {
    super.initState();
    context.read<MyOrdersBloc>().add(GetMyOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrdersBloc, MyOrdersState>(
      builder: (context, state) {
        if (state.status == myOrdersStatus.loading) {
          return const LoadingPlaceHolder(
            shimmerType: ShimmerType.list,
            cellShimmerHeight: 50,
            shimmerCount: 10,
          );
        } else if (state.status == myOrdersStatus.success){
          final orders = state.orders;
          final currentOrders = orders.where((e) => e.status == "Approved").toList();

          if(currentOrders.isEmpty) {
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
                        subTitle: 'لم يتم العثور على اي طلبات جارية حتي الانً',
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return ListView.builder(
            itemCount: currentOrders.length,
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
                            currentOrders[index].itemImages == null ?
                            Image.asset(
                              'assets/images/virtual_image.jpg', width: 90.w,
                              height: 90.h,
                              fit: BoxFit.contain,)
                                : Image.network(
                              currentOrders[index].itemImages!.first,
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
                                  currentOrders[index].itemName ?? '',
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
                                      "المالك: ${currentOrders[index].ownerName ?? ''}",
                                      style: font13kLightPrimaryColorMedium.copyWith(
                                        color: kBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(5.h),
                                Row(
                                  children: [
                                    Image.asset('assets/images/date_determine.png'),
                                    Gap(5.w),
                                    Text(
                                      '${currentOrders[index].fromDate ?? ''} - ${currentOrders[index].toDate ?? ''}',
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
                                    Image.asset('assets/images/remainder.png'),
                                    Gap(5.w),
                                    Text(
                                      ' متبقي ${currentOrders[index].timeLeftInDays.toString() ?? ''} يوم',
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
                              currentOrders[index].totalPrice.toString(),
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
                              text: 'مراسلة المالك',
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
    } else if (state.status == myOrdersStatus.failure) {
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
            isNotIcon ? SizedBox() : Image.asset(icon, color: kPrimaryColor, width: 20.w, height: 20.h),
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
