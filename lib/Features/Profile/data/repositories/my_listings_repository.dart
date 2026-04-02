import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Profile/data/models/my_listings_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MyListingsRepository {

  Future<MyListingsModel> getMyListings() async {
    return NetworkUtil.internal().get(
      MyListingsModel(),
      "${baseUrl}Items/my-listings?IsAvailable=true&PageIndex=1&PageSize=30",
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization": "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
      }),
    );
  }


}

MyListingsRepository myListingsRepository = MyListingsRepository();