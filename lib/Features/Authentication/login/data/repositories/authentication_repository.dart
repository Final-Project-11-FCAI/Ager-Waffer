import 'dart:convert';

import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/forget_password_model.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/register_model.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/reset_password_model.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/verify_otp_model.dart';
import 'package:ager_waffer/Features/Authentication/login/domain/entities/register_entity.dart';
import 'package:dio/dio.dart';
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
    String? fileName = registerEntity!.profileImage?.path.split('/').last;

    FormData formData = FormData.fromMap({
      "FirstName": registerEntity.firstName,
      "LastName": registerEntity.lastName,
      "Email": registerEntity.email,
      "Password": registerEntity.password,

      if (registerEntity.profileImage != null)
        "ProfileImage": await MultipartFile.fromFile(
          registerEntity.profileImage!.path,
          filename: fileName,
        ),
    });

    return NetworkUtil.internal().post(RegisterModel(),
        baseUrl +  registerUrl,
        body: formData,
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
        }));
  }



  Future<ForgetPasswordModel> forgetPassword({String? email,}) async {
    return NetworkUtil.internal().post(ForgetPasswordModel(),
        baseUrl +  forgetPasswordUrl,
        body: jsonEncode({
          "email": email,
        }),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
        }));
  }


  Future<VerifyOtpModel> verifyOtp({String? email, String? otp}) async {
    return NetworkUtil.internal().post(VerifyOtpModel(),
        baseUrl +  verifyOtpUrl,
        body: jsonEncode( {
          "email": email,
          "otp": otp,
        }),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
        }));
  }


  Future<ResetPasswordModel> resetPassword({String? email, String? newPassword}) async {
    return NetworkUtil.internal().post(ResetPasswordModel(),
        baseUrl +  resetPasswordUrl,
        body: jsonEncode( {
          "email": email,
          "newPassword": newPassword,
        }),
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
        }));
  }


}

AuthenticationRepository authenticationRepository = AuthenticationRepository();