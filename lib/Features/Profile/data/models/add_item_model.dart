import 'package:ager_waffer/Base/network/network-mappers.dart';

class AddItemModel extends BaseMappable{
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  AddItemModel(
      {this.isSuccess,
        this.data,
        this.messageAr,
        this.messageEn,
        this.statusCode,
      });

  AddItemModel.fromJson(Map<String, dynamic> json) {
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
    return AddItemModel(isSuccess: isSuccess,data: data,messageAr: messageAr,messageEn: messageEn, statusCode: statusCode,);
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  int? price;
  int? insurance;
  String? condition;
  String? rentUnit;
  bool? isAvailable;
  int? averageRate;
  List<String>? itemImages;
  String? categoryName;
  String? ownerName;
  String? ownerPictureUrl;
  String? city;

  Data(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.insurance,
        this.condition,
        this.rentUnit,
        this.isAvailable,
        this.averageRate,
        this.itemImages,
        this.categoryName,
        this.ownerName,
        this.ownerPictureUrl,
        this.city});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    insurance = json['insurance'];
    condition = json['condition'];
    rentUnit = json['rentUnit'];
    isAvailable = json['isAvailable'];
    averageRate = json['averageRate'];
    itemImages = json['itemImages'].cast<String>();
    categoryName = json['categoryName'];
    ownerName = json['ownerName'];
    ownerPictureUrl = json['ownerPictureUrl'];
    city = json['city'];
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
    data['averageRate'] = this.averageRate;
    data['itemImages'] = this.itemImages;
    data['categoryName'] = this.categoryName;
    data['ownerName'] = this.ownerName;
    data['ownerPictureUrl'] = this.ownerPictureUrl;
    data['city'] = this.city;
    return data;
  }
}

AddItemModel addItemModel = AddItemModel();