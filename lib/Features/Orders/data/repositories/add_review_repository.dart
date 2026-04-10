import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../models/add_review_model.dart';

class AddReviewRepository {

  Future<AddReviewModel> addReview({
    required int reviewType,
    required int itemId,
    String? reviewedUserId,
    required String reviewText,
    required int rate,
  }) async {

    final Map<String, dynamic> body = {
      "reviewType": reviewType,
      "itemId": itemId,
      "reviewText": reviewText,
      "rate": rate,
      if (reviewedUserId != null) "reviewedUserId": reviewedUserId,
    };

    return NetworkUtil.internal().post(
      AddReviewModel(),
      baseUrl + addReviewUrl,
      body: body,
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization":
        "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

AddReviewRepository addReviewRepository = AddReviewRepository();