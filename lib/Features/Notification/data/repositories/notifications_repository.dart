import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Notification/data/models/notifications_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class NotificationsRepository {

  Future<NotificationsModel> getNotifications({
    int pageIndex = 1,
    int pageSize = 50,
  }) async {
    return NetworkUtil.internal().get(
      NotificationsModel(),
      "${baseUrl}Notifications?pageIndex=$pageIndex&pageSize=$pageSize",
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization":
        "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

NotificationsRepository notificationsRepository = NotificationsRepository();