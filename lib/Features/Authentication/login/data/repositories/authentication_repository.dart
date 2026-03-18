import 'dart:convert';

import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AuthenticationRepository {

  Future<LoginModel> login({String? email ,String? password }) async {
    return NetworkUtil.internal().post(LoginModel(),
        baseUrl +  loginUrl,
        body: jsonEncode( {
          "email": email,
          "password" : password,
        }),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
        }));
  }


}

AuthenticationRepository authenticationRepository = AuthenticationRepository();