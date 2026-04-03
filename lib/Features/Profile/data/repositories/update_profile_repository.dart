import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Profile/data/models/update_profile_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class UpdateProfileRepository {
  Future<UpdateProfileModel> updateProfile({
    required String firstName,
    required String lastName,
    String? phone,
    String? password,
    XFile? profileImage,
  }) async {
    final formData = FormData.fromMap({
      'FirstName': firstName,
      'LastName': lastName,
      if (phone != null) 'PhoneNumber': phone,
      if (password != null) 'Password': password,
      if (profileImage != null)
        'ProfileImage': await MultipartFile.fromFile(
          profileImage.path,
          filename: profileImage.path.split('/').last,
        ),
    });

    final url = '$baseUrl$updateProfileUrl';

    return NetworkUtil.internal().put(
      UpdateProfileModel(),
      url,
      body: formData,
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

UpdateProfileRepository updateProfileRepository = UpdateProfileRepository();