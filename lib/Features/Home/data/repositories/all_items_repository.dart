import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AllItemsRepository {

  Future<AllItemsModel> getAllItems() async {
    return NetworkUtil.internal().get(
      AllItemsModel(),
      "${baseUrl}Items?pageIndex=1&pageSize=50",
      headers: Map<String, String>.from({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
      }),
    );
  }


}

AllItemsRepository allItemsRepository = AllItemsRepository();