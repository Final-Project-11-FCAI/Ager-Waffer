import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Home/data/models/send_request_model.dart';
import 'package:ager_waffer/Features/Home/domain/entities/send_request_entity.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class SendRequestRepository {

  Future<SendRequestModel> sendRequest({
    required SendRequestEntity sendRequestEntity,
  }) async {

    Map<String, dynamic> body = {
      "itemId": sendRequestEntity.itemId,
      "fromDate": sendRequestEntity.fromDate,
      "toDate": sendRequestEntity.toDate,
      "agreeToTerms": sendRequestEntity.agreeToTerms,
    };

    return NetworkUtil.internal().post(
      SendRequestModel(),
      baseUrl + sendRequestsUrl,
      body: body,
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization":
        "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

SendRequestRepository sendRequestRepository = SendRequestRepository();