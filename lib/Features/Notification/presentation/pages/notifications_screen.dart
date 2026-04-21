import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Shimmer/loading_shimmer.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Notification/domain/entities/notification_entity.dart';
import 'package:ager_waffer/Features/Notification/presentation/manager/notifications_bloc.dart';
import 'package:ager_waffer/Features/Notification/presentation/manager/notifications_state.dart';
import 'package:ager_waffer/Features/Notification/presentation/widgets/notification_item.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/custom_error_widget.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/empty_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../Base/common/local_const.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<NotificationsBloc>().add(GetNotificationsEvent());
  }

  List<NotificationEntity> todayNotifications = [
    NotificationEntity(
      title: "رسالة جديدة",
      message: "لديك رسالة من ذي يونس",
      time: "منذ دقيقتين",
      icon: Icons.chat,
      color: Colors.blue,
    ),
    NotificationEntity(
      title: "طلب إيجار جديد",
      message: "أرسل أحمد محمد طلب لاستئجار منتجك",
      time: "منذ خمس ساعات",
      icon: Icons.inventory,
      color: Colors.orange,
    ),
  ];

  List<NotificationEntity> yesterdayNotifications = [
    NotificationEntity(
      title: "تم قبول الطلب",
      message: "تم قبول طلبك لاستئجار مشاية أطفال",
      time: "3:15 م",
      icon: Icons.check_circle,
      color: Colors.green,
    ),
    NotificationEntity(
      title: "تقييم جديد",
      message: "قام حمزة محمود بتقييم منتجك",
      time: "10:05 م",
      icon: Icons.star,
      color: Colors.amber,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhiteColor,
        title: Text("الإشعارات",
          style: font16BlackSemiBold.copyWith(
            fontSize: 20,
            color: kWhiteColor,
          ),
        ),
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
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              "اليوم",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(10.h),
            BlocBuilder<NotificationsBloc, NotificationsState>(
              builder: (context, state) {
                if(state.status == notificationsStatus.loading) {
                  return const LoadingPlaceHolder(
                    shimmerType: ShimmerType.list,
                    cellShimmerHeight: 50,
                    shimmerCount: 10,
                  );
                }else if (state.status == notificationsStatus.success){
                  final notifications = state.notifications;

                  if(notifications.isEmpty) {
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
                    itemCount: notifications.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NotificationItem(notifications: notifications[index],);
                    },
                  );
                } else if (state.status == notificationsStatus.failure) {
                  return CustomErrorWidget(
                    message: state.failureMessage,
                    onRetry: () {
                      context.read<NotificationsBloc>().add(
                        GetNotificationsEvent(),
                      );
                    },
                  );
                } else {
                  return Center(child: Text(kNoDataYet.tr()));
                }
              },
            ),
          ],
        ),
      )
    );
  }
}