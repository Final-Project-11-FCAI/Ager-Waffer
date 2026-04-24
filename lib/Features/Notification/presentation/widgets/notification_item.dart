import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Notification/data/models/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notifications});

  final NotificationsData notifications;

  String formatTime(String date) {
    final parsed = DateTime.parse(date).toLocal();

    final isArabic =
        LocalizeAndTranslate.getLanguageCode() == 'ar';

    if (isArabic) {
      return DateFormat('hh:mm a', 'ar').format(parsed);
    } else {
      return DateFormat('hh:mm a', 'en').format(parsed);
    }
  }

  String formatDateSmart(String date) {
    try {
      final now = DateTime.now();
      final parsedDate = DateTime.parse(date).toLocal();

      final isToday =
          now.year == parsedDate.year &&
          now.month == parsedDate.month &&
          now.day == parsedDate.day;

      if (isToday) {
        return formatTime(date);
      }

      final diff = now.difference(parsedDate);

      if (diff.inSeconds < 60) {
        return kMomentsAgo.tr();
      }

      if (diff.inMinutes < 60) {
        return LocalizeAndTranslate.getLanguageCode() == 'ar'
            ? "${kMinutesAgo.tr()} ${diff.inMinutes} دقيقة"
            : "${diff.inMinutes} ${kMinutesAgo.tr()}";
      }

      if (diff.inHours < 24) {
        return LocalizeAndTranslate.getLanguageCode() == 'ar'
            ? "${kHoursAgo.tr()} ${diff.inHours} ساعة"
            : "${diff.inHours} ${kHoursAgo.tr()}";
      }

      if (diff.inDays <= 7) {
        return LocalizeAndTranslate.getLanguageCode() == 'ar'
            ? "${kDaysAgo.tr()} ${diff.inDays} يوم"
            : "${diff.inDays} ${kDaysAgo.tr()}";
      }

      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return kDate.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      leading: notifications.subType == 'completed'
          ? Image.asset('assets/images/new_request.png')
          : notifications.subType == 'declined'
          ? Image.asset('assets/images/cancel_request.png')
          : notifications.subType == 'accepted'
          ? Image.asset('assets/images/accept_request.png')
          : Image.asset('assets/images/new_notification.png'),
      title: Text(notifications.title!, style: font20PrimaryMedium),
      subtitle: Text(
        notifications.body!,
        style: font13kLightPrimaryColorMedium.copyWith(fontSize: 15),
      ),
      trailing: Text(
        formatDateSmart(notifications.createdAt!),
        style: font13kLightPrimaryColorMedium.copyWith(color: kTextColor),
      ),
    );
    ;
  }
}
