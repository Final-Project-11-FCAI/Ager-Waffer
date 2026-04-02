import 'package:ager_waffer/Base/network/network-mappers.dart';

class MyListingsModel extends BaseMappable {
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  MyListingsModel({
    this.isSuccess,
    this.data,
    this.messageAr,
    this.messageEn,
    this.statusCode,
  });

  MyListingsModel.fromJson(Map<String, dynamic> json) {
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

    return MyListingsModel(
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
  List<MyListingsData>? data;

  Data({this.pageIndex, this.pageSize, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    count = json['count'];
    if (json['data'] != null) {
      data = <MyListingsData>[];
      json['data'].forEach((v) {
        data!.add(new MyListingsData.fromJson(v));
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

class MyListingsData {
  int? id;
  String? name;
  String? description;
  double? price;
  double? insurance;
  String? condition;
  String? rentUnit;
  bool? isAvailable;
  double? averageRate;
  List<String>? itemImages;
  String? categoryName;
  String? ownerName;
  String? ownerPictureUrl;
  String? city;

  MyListingsData({
    this.id,
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
    this.city,
  });

  MyListingsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    description = json['description'];
    price = (json['price'] as num?)?.toDouble() ?? 0.0;
    insurance = (json['insurance'] as num?)?.toDouble();
    condition = json['condition'];
    rentUnit = json['rentUnit'];
    isAvailable = json['isAvailable'];
    averageRate = (json['averageRate'] as num?)?.toDouble();
    itemImages = json['itemImages'].cast<String>();
    categoryName = json['categoryName'];
    ownerName = json['ownerName'];
    ownerPictureUrl = json['ownerPictureUrl']?.toString();
    city = json['city']?.toString() ?? 'Unknown';
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
