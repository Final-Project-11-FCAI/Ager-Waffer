// import 'package:ager_waffer/Base/common/config.dart';
// import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
// import 'package:ager_waffer/Base/network/network_util.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';
//
// class GetMessagesRepository {
//
//   Future<GetMessagesModel> getMessages({
//     required String conversationId,
//   }) async {
//
//     return NetworkUtil.internal().get(
//       GetMessagesModel(),
//       "$baseUrl/Chat/conversations/$conversationId/messages",
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
//         'Language':
//         LocalizeAndTranslate.getLanguageCode().toUpperCase(),
//       },
//     );
//   }
// }
//
// final GetMessagesRepository getMessagesRepository = GetMessagesRepository();