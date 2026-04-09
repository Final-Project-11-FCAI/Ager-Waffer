import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Orders/data/models/my_orders_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MyOrdersRepository {

  Future<MyOrdersModel> getMyOrders() async {
    return NetworkUtil.internal().get(
      MyOrdersModel(),
      baseUrl + myOrdersUrl,
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization":
        "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

MyOrdersRepository myOrdersRepository = MyOrdersRepository();