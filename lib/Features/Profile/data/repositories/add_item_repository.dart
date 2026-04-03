import 'dart:convert';
import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Profile/data/models/add_item_model.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/domain/entities/add_item_entity.dart';
import 'package:dio/dio.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AddItemRepository {

  Future<AddItemModel> addItem({AddItemEntity? addItemEntity}) async {

    List<MultipartFile> imagesList = [];

    var images = addItemEntity?.images ?? [];

    for (var image in images) {
      imagesList.add(
        await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      );
    }

    FormData formData = FormData.fromMap({
      "Name": addItemEntity!.name,
      "Description": addItemEntity.description,
      "Price": addItemEntity.price,
      "Insurance": addItemEntity.insurance,
      "Condition": addItemEntity.condition,
      "RentUnit": addItemEntity.rentUnit,
      "CategoryName": addItemEntity.categoryName,
      "City": addItemEntity.city,
      "IsAvailable": addItemEntity.isAvailable,

    if (imagesList.isNotEmpty) "Images": imagesList,
    });

    return NetworkUtil.internal().post(AddItemModel(),
        baseUrl +  addItemUrl,
        body: formData,
        headers: Map<String, String>.from({
          'Accept': 'application/json',
          "Authorization": "Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}",
          'Language': LocalizeAndTranslate.getLanguageCode().toUpperCase()
        }));
  }


}

AddItemRepository addItemRepository = AddItemRepository();