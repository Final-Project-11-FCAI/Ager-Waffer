import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Chat/data/models/all_chats_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AllChatsRepository {
  Future<AllChatsModel> getAllChats() async {
    return NetworkUtil.internal().get(
      AllChatsModel(),
      baseUrl + allChatsUrl,
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization":
            "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

AllChatsRepository allChatsRepository = AllChatsRepository();
