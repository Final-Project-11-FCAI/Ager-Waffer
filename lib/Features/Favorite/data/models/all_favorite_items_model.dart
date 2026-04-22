import 'package:ager_waffer/Base/network/network-mappers.dart';

class AllFavoriteItemsModel extends BaseMappable {
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  AllFavoriteItemsModel({
    this.isSuccess,
    this.data,
    this.messageAr,
    this.messageEn,
    this.statusCode,
  });

  AllFavoriteItemsModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['messageAr'] = this.messageAr;
    data['messageEn'] = this.messageEn;
    data['statusCode'] = this.statusCode;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
    statusCode = json['statusCode'];
    return AllFavoriteItemsModel(
      isSuccess: isSuccess,
      data: data,
      messageAr: messageAr,
      messageEn: messageEn,
      statusCode: statusCode,
    );
  }
}

class Data {
  int? pageIndex;
  int? pageSize;
  int? count;
  List<FavoriteData>? data;

  Data({this.pageIndex, this.pageSize, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    count = json['count'];
    if (json['data'] != null) {
      data = <FavoriteData>[];
      json['data'].forEach((v) {
        data!.add(new FavoriteData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteData {
  int? id;
  int? itemId;
  String? name;
  String? description;
  double? price;
  double? insurance;
  bool? isAvailable;
  String? condition;
  double? averageRate;
  String? rentUnit;
  String? categoryName;
  Null? ownerName;
  List<String>? imageUrls;
  String? addedAt;

  FavoriteData({
    this.id,
    this.itemId,
    this.name,
    this.description,
    this.price,
    this.insurance,
    this.isAvailable,
    this.condition,
    this.averageRate,
    this.rentUnit,
    this.categoryName,
    this.ownerName,
    this.imageUrls,
    this.addedAt,
  });

  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['itemId'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    insurance = json['insurance'];
    isAvailable = json['isAvailable'];
    condition = json['condition'];
    averageRate = json['averageRate'];
    rentUnit = json['rentUnit'];
    categoryName = json['categoryName'];
    ownerName = json['ownerName'];
    imageUrls = json['imageUrls'].cast<String>();
    addedAt = json['addedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemId'] = this.itemId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['insurance'] = this.insurance;
    data['isAvailable'] = this.isAvailable;
    data['condition'] = this.condition;
    data['averageRate'] = this.averageRate;
    data['rentUnit'] = this.rentUnit;
    data['categoryName'] = this.categoryName;
    data['ownerName'] = this.ownerName;
    data['imageUrls'] = this.imageUrls;
    data['addedAt'] = this.addedAt;
    return data;
  }
}
