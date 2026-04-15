import 'package:ager_waffer/Base/network/network-mappers.dart';

class OrdersManagementModel extends BaseMappable {
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  OrdersManagementModel({
    this.isSuccess,
    this.data,
    this.messageAr,
    this.messageEn,
    this.statusCode,
  });

  OrdersManagementModel.fromJson(Map<String, dynamic> json) {
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
    return OrdersManagementModel(
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
  List<OrderManagementData>? data;

  Data({this.pageIndex, this.pageSize, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    count = json['count'];
    if (json['data'] != null) {
      data = <OrderManagementData>[];
      json['data'].forEach((v) {
        data!.add(new OrderManagementData.fromJson(v));
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

class OrderManagementData {
  int? requestId;
  int? itemId;
  List<String>? itemImages;
  String? itemName;
  String? itemCondition;
  String? avrageRate;
  String? status;
  String? fromDate;
  String? toDate;
  int? timeLeftInDays;
  double? price;
  double? insurance;
  String? rentUnit;
  double? totalPrice;
  String? renteeId;
  String? renteeName;
  String? email;
  String? phoneNumber;
  String? governorate;
  String? city;
  String? street;

  OrderManagementData({
    this.requestId,
    this.itemId,
    this.itemImages,
    this.itemName,
    this.itemCondition,
    this.avrageRate,
    this.status,
    this.fromDate,
    this.toDate,
    this.timeLeftInDays,
    this.price,
    this.insurance,
    this.rentUnit,
    this.totalPrice,
    this.renteeId,
    this.renteeName,
    this.email,
    this.phoneNumber,
    this.governorate,
    this.city,
    this.street,
  });

  OrderManagementData.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    itemId = json['itemId'];
    itemImages = json['itemImages'].cast<String>();
    itemName = json['itemName'];
    itemCondition = json['itemCondition'];
    avrageRate = json['avrageRate'];
    status = json['status'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    timeLeftInDays = json['timeLeftInDays'];
    price = json['price'];
    insurance = json['insurance'];
    rentUnit = json['rentUnit'];
    totalPrice = (json['totalPrice'] as num?)?.toDouble();
    renteeId = json['renteeId'];
    renteeName = json['renteeName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    governorate = json['governorate'];
    city = json['city'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['itemId'] = this.itemId;
    data['itemImages'] = this.itemImages;
    data['itemName'] = this.itemName;
    data['itemCondition'] = this.itemCondition;
    data['avrageRate'] = this.avrageRate;
    data['status'] = this.status;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['timeLeftInDays'] = this.timeLeftInDays;
    data['price'] = this.price;
    data['insurance'] = this.insurance;
    data['rentUnit'] = this.rentUnit;
    data['totalPrice'] = this.totalPrice;
    data['renteeId'] = this.renteeId;
    data['renteeName'] = this.renteeName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['governorate'] = this.governorate;
    data['city'] = this.city;
    data['street'] = this.street;
    return data;
  }
}
