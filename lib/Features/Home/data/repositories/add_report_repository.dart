import 'dart:io';

import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Home/data/models/add_report_model.dart';
import 'package:ager_waffer/Features/Home/domain/entities/add_report_entity.dart';
import 'package:dio/dio.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AddReportRepository {

  Future<AddReportModel> addReport({
    AddReportEntity? addReportEntity,
  }) async {

    MultipartFile? attachmentFile;

    if (addReportEntity?.attachment != null) {
      attachmentFile = await MultipartFile.fromFile(
        addReportEntity!.attachment.path,
        filename: addReportEntity.attachment.path.split('/').last,
      );
    }

    FormData formData = FormData.fromMap({
      "Description": addReportEntity!.description,
      "Type": addReportEntity.type,
      "ReportedUserId": addReportEntity.reportedUserId,

      if (attachmentFile != null)
        "Attachment": attachmentFile,
    });

    return NetworkUtil.internal().post(
      AddReportModel(),
      baseUrl + addReportUrl,
      body: formData,
      headers: Map<String, String>.from({
        'Accept': 'application/json',
        "Authorization":
        "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
        'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase(),
      }),
    );
  }
}

AddReportRepository addReportRepository = AddReportRepository();