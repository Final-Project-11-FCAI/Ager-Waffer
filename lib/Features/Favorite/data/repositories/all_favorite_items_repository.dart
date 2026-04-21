import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Favorite/data/models/all_favorite_items_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AllFavoriteItemsRepository {

  Future<AllFavoriteItemsModel> getFavoriteItems({
    int pageIndex = 1,
    int pageSize = 20,
  }) async {
    return NetworkUtil.internal().get(
      AllFavoriteItemsModel(),
      "${baseUrl}FavoriteItems?pageIndex=$pageIndex&pageSize=$pageSize",
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization":
        "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

AllFavoriteItemsRepository allFavoriteItemsRepository = AllFavoriteItemsRepository();