import 'dart:convert';

import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/register_model.dart';
import 'package:ager_waffer/Features/Authentication/login/domain/entities/register_entity.dart';
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


  Future<RegisterModel> register({RegisterEntity? registerEntity}) async {

    return NetworkUtil.internal().post(RegisterModel(),
        baseUrl +  registerUrl,
        body: jsonEncode({
          "FirstName": registerEntity!.firstName,
          "LastName": registerEntity!.lastName,
          "Email": registerEntity.email,
          "Password": registerEntity.password,
          "ProfileImage": registerEntity.profileImage,
        }),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
        }));
  }



}

AuthenticationRepository authenticationRepository = AuthenticationRepository();