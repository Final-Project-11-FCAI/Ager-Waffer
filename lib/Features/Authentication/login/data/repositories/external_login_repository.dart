import 'dart:convert';

import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ExternalLoginRepository {
  Future<LoginModel> externalLogin({
    required String provider, // google or facebook
    required String accessToken,
  }) async {
    return NetworkUtil.internal().post(
      LoginModel(),
      baseUrl + externalLoginUrl,
      body: jsonEncode({
        "provider": provider,
        "accessToken": accessToken,
      }),
      headers: Map<String, String>.from({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}