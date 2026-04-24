import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Chat/data/models/firebase/fire_database.dart';
import 'package:ager_waffer/Features/Chat/data/models/user_model.dart';
import 'package:ager_waffer/Features/Chat/presentation/pages/chat_screen.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/orders_management_bloc.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/manager/orders_management_state.dart';
import 'package:ager_waffer/Features/Manage_Orders/presentation/pages/show_details_screen.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/custom_error_widget.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

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
                          title: kNoCurrentOrders.tr(),
                          subTitle: kNoCurrentOrdersDesc.tr(),
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
                              CachedNetworkImage(
                                imageUrl: currentOrdersManagement[index].itemImages!.first,
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
                                        "${kOwner.tr()}: ${currentOrdersManagement[index].renteeName}",
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
                                        "${kRemaining.tr()} ${currentOrdersManagement[index].timeLeftInDays} ${kDays.tr()}",
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
                                kTotalAmount.tr(),
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
                                text:  kViewDetails.tr(),
                                icon: 'assets/images/refresh.png',
                                backgroundColor: kLightPrimaryColor,
                                textColor: kWhiteColor,
                                isNotIcon: true,
                                onTap: () {
                                  customAnimatedPushNavigation(context, ShowDetailsScreen(
                                    currentManageOrders: currentOrdersManagement[index],
                                  ));
                                },
                              ),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where('email', isEqualTo: currentOrdersManagement[index].email)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  }

                                  final uid = snapshot.data!.docs.first.id;
                                  print("##uid : ${uid}");

                                  return orderButton(
                                    text: kContactRenter.tr(),
                                    icon: 'assets/images/contact_icon.png',
                                    backgroundColor: kWhiteColor,
                                    textColor: kPrimaryColor,
                                    onTap: () async {
                                      print("ownerEmail: ${currentOrdersManagement[index].email}");
                                      final roomId = await FireData()
                                          .createRoom(currentOrdersManagement[index].email!)
                                          .onError((error, stackTrace) {
                                        print("error: ${error}");
                                        print("stackTrace: ${stackTrace}");
                                      });
                                      print("roomId: ${roomId}");
                                      if (roomId != null) {
                                        customAnimatedPushNavigation(
                                          context,
                                          ChatScreen(
                                            roomId: roomId,
                                            chatUser: ChatUser(
                                              id: uid,
                                              name: currentOrdersManagement[index].renteeName,
                                              image: "assets/images/virtual_user.jpg",
                                              about: "Hello I'm ${currentOrdersManagement[index].renteeName}",
                                              email: currentOrdersManagement[index].email,
                                              createdAt: DateTime.now().millisecondsSinceEpoch
                                                  .toString(),
                                              lastActivated: DateTime.now().millisecondsSinceEpoch
                                                  .toString(),
                                              pushToken: '',
                                              online: false,
                                              myUsers: [],
                                            ),
                                          ),
                                        );
                                      } else {
                                        print("EMAIL: ${currentOrdersManagement[index].email}");
                                        print("ID: ${currentOrdersManagement[index].renteeId}");
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(SnackBar(content: Text("User not found")));
                                      }
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
          } else if (state.status == ordersManagementStatus.failure) {
            return CustomErrorWidget(
              message: state.failureMessage,
              onRetry: () {
                context.read<OrdersManagementBloc>().add(
                  GetOrdersManagementEvent(),
                );
              },
            );
          } else {
            return Center(child: Text(kNoDataYet.tr()));
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
