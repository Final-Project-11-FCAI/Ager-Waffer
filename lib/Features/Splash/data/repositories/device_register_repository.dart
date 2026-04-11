import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Splash/data/models/device_register_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DeviceRegisterRepository {

  Future<DeviceRegisterModel> registerDevice({
    required String fcmToken,
    required String devicePlatform,
  }) async {

    Map<String, dynamic> body = {
      "fcmToken": fcmToken,
      "devicePlatform": devicePlatform,
    };

    return NetworkUtil.internal().post(
      DeviceRegisterModel(),
      baseUrl + deviceRegisterUrl,
      body: body,
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization":
        "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

DeviceRegisterRepository deviceRegisterRepository = DeviceRegisterRepository();