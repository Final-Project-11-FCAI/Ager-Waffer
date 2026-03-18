import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Notification/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          color: notification.color.withOpacity(.15),
          shape: BoxShape.circle,
        ),
        child: Icon(notification.icon, color: notification.color),
      ),
      title: Text(
        notification.title,
        style: font20PrimaryMedium,
      ),
      subtitle: Text(notification.message, style: font13kLightPrimaryColorMedium.copyWith(fontSize: 15),),
      trailing: Text(notification.time, style: font13kLightPrimaryColorMedium.copyWith(color: kTextColor,),),
    );;
  }
}
