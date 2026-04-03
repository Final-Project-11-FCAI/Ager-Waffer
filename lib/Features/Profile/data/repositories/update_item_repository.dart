import 'package:ager_waffer/Base/common/config.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/network/network_util.dart';
import 'package:ager_waffer/Features/Home/domain/entities/add_item_entity.dart';
import 'package:ager_waffer/Features/Profile/data/models/update_item_model.dart';
import 'package:dio/dio.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class UpdateItemRepository {
  /// Same multipart shape as [AddItemRepository.addItem], PUT to `Items/{id}`.
  Future<UpdateItemModel> updateItem({
    required int productId,
    required AddItemEntity addItemEntity,
  }) async {
    final List<MultipartFile> imagesList = [];
    final images = addItemEntity.images ?? [];

    for (final image in images) {
      imagesList.add(
        await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      );
    }

    final formData = FormData.fromMap({
      'Name': addItemEntity.name,
      'Description': addItemEntity.description,
      'Price': addItemEntity.price,
      'Insurance': addItemEntity.insurance,
      'Condition': addItemEntity.condition,
      'RentUnit': addItemEntity.rentUnit,
      'CategoryName': addItemEntity.categoryName,
      'City': addItemEntity.city,
      'IsAvailable': addItemEntity.isAvailable,
      if (imagesList.isNotEmpty) 'Images': imagesList,
    });

    final url = '$baseUrl$addItemUrl/$productId';

    return NetworkUtil.internal().put(
      UpdateItemModel(),
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

UpdateItemRepository updateItemRepository = UpdateItemRepository();