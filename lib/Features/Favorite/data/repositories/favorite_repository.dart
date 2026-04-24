import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Favorite/data/models/favorite_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class FavoriteRepository {

  Future<FavoriteModel> toggleFavorite({required int itemId}) async {

    return NetworkUtil.internal().post(
      FavoriteModel(),
      "${baseUrl}FavoriteItems/toggle/$itemId",
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization":
        "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

FavoriteRepository favoriteRepository = FavoriteRepository();