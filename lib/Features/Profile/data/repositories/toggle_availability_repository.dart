import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Profile/data/models/toggle_availability_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ToggleAvailabilityRepository {
  Future<ToggleAvailabilityModel> toggleAvailability({
    required int id,
    required bool isAvailable,
  }) async {

    final url = Uri.parse(baseUrl)
        .resolve('Items/$id/availability')
        .toString();

    final body = {
      'IsAvailable': isAvailable,
    };

    return NetworkUtil.internal().patch(
      ToggleAvailabilityModel(),
      url,
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization':
        'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
        'Language':
        LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      },
    );
  }
}

ToggleAvailabilityRepository toggleAvailabilityRepository =
ToggleAvailabilityRepository();