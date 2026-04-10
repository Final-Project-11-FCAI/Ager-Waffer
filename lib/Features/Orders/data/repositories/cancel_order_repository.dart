import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Orders/data/models/cancel_order_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CancelOrderRepository {

  Future<CancelOrderModel> cancelOrder({
    required int orderId,
  }) async {
    return NetworkUtil.internal().patch(
      CancelOrderModel(),
      "${baseUrl}RentalRequests/$orderId/cancel",
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

CancelOrderRepository cancelOrderRepository = CancelOrderRepository();