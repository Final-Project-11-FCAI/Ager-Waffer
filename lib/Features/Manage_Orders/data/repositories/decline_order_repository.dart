import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Manage_Orders/data/models/decline_order_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DeclineOrderRepository {

  Future<DeclineOrderModel> declineOrder({
    required int orderId,
  }) async {
    return NetworkUtil.internal().patch(
      DeclineOrderModel(),
      "${baseUrl}RentalRequests/$orderId/decline",
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

DeclineOrderRepository declineOrderRepository = DeclineOrderRepository();