import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Home/data/models/reviews_about_user_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ReviewsAboutUserRepository {

  Future<ReviewsAboutUserModel> getUserReviews(String userId) async {
    return NetworkUtil.internal().get(
      ReviewsAboutUserModel(),
      "${baseUrl}Review/users/$userId/received",
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization":
        "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }

}

ReviewsAboutUserRepository reviewsAboutUserRepository = ReviewsAboutUserRepository();