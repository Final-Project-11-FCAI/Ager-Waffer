import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Notification/domain/entities/notification_entity.dart';
import 'package:ager_waffer/Features/Notification/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

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
            ListView.builder(
              itemCount: todayNotifications.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return NotificationItem(notification: todayNotifications[index],);
              },
            ),
            Gap(20.h),
            Text(
              "أمس",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            ListView.builder(
              itemCount: yesterdayNotifications.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return NotificationItem(notification: yesterdayNotifications[index],);
              },
            ),
          ],
        ),
      )
    );
  }
}