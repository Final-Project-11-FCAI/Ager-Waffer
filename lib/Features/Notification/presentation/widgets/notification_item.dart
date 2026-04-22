import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Notification/data/models/notifications_model.dart';
import 'package:ager_waffer/Features/Notification/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notifications});

  final NotificationsData notifications;

  String formatTime(String date) {
    final DateTime parsed = DateTime.parse(date).toLocal();
    return DateFormat('hh:mm a').format(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          color: kGreyColor,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.not_accessible, color: kPrimaryColor),
      ),
      title: Text(
        notifications.title!,
        style: font20PrimaryMedium,
      ),
      subtitle: Text(notifications.body!, style: font13kLightPrimaryColorMedium.copyWith(fontSize: 15),),
      trailing: Text(formatTime(notifications.createdAt!), style: font13kLightPrimaryColorMedium.copyWith(color: kTextColor,),),
    );;
  }
}
