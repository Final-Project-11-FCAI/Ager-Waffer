import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Home/data/models/item_reviews_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ItemReviewRepository {

  Future<ItemReviewsModel> getItemReviews(int itemId) async {
    return NetworkUtil.internal().get(
      ItemReviewsModel(),
      "${baseUrl}Review/items/$itemId",
      headers: Map<String, String>.from({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }

}

ItemReviewRepository itemReviewRepository = ItemReviewRepository();