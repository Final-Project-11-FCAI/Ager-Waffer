import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Profile/data/models/delete_item_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DeleteItemRepository {

  Future<DeleteItemModel> deleteProduct(int productId) async {
    return NetworkUtil.internal().delete(
      DeleteItemModel(),
      "${baseUrl}Items/$productId",
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization": "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
      }),
    );
  }

}

DeleteItemRepository deleteItemRepository = DeleteItemRepository();