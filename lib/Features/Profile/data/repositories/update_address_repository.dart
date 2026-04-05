import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Profile/data/models/update_address_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class UpdateAddressRepository {
  Future<UpdateAddressModel> updateAddress({
    required String city,
    required String street,
    required String governorate,
    required String phoneNumber,
  }) async {

    return NetworkUtil.internal().put(
      UpdateAddressModel(),
      baseUrl + updateAddressUrl,
      body: {
        "city": city,
        "street": street,
        "governorate": governorate,
        "phoneNumber": phoneNumber,
      },
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization':
        'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

UpdateAddressRepository updateAddressRepository = UpdateAddressRepository();