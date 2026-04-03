import 'package:ager_waffer/Base/network/network-mappers.dart';

class UpdateItemModel extends BaseMappable{
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  UpdateItemModel(
      {this.isSuccess,
        this.data,
        this.messageAr,
        this.messageEn,
        this.statusCode,
       });

  UpdateItemModel.fromJson(Map<String, dynamic> json) {
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
    return UpdateItemModel(
      isSuccess: isSuccess,
      data: data,
      messageAr: messageAr,
      messageEn: messageEn,
      statusCode: statusCode,
    );
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  double? price;
  double? insurance;
  String? condition;
  String? rentUnit;
  bool? isAvailable;
  List<String>? itemImages;
  String? categoryName;
  String? ownerName;
  String? ownerPictureUrl;
  String? city;
  double? averageRate;

  Data(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.insurance,
        this.condition,
        this.rentUnit,
        this.isAvailable,
        this.itemImages,
        this.categoryName,
        this.ownerName,
        this.ownerPictureUrl,
        this.city,
        this.averageRate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = (json['price'] as num?)?.toDouble() ?? 0.0;
    insurance = (json['insurance'] as num?)?.toDouble();
    condition = json['condition'];
    rentUnit = json['rentUnit'];
    isAvailable = json['isAvailable'];
    itemImages = json['itemImages'] != null
        ? List<String>.from(json['itemImages'] as List)
        : null;
    categoryName = json['categoryName'];
    ownerName = json['ownerName'];
    ownerPictureUrl = json['ownerPictureUrl'];
    city = json['city'];
    averageRate = (json['averageRate'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['insurance'] = this.insurance;
    data['condition'] = this.condition;
    data['rentUnit'] = this.rentUnit;
    data['isAvailable'] = this.isAvailable;
    data['itemImages'] = this.itemImages;
    data['categoryName'] = this.categoryName;
    data['ownerName'] = this.ownerName;
    data['ownerPictureUrl'] = this.ownerPictureUrl;
    data['city'] = this.city;
    data['averageRate'] = this.averageRate;
    return data;
  }
}