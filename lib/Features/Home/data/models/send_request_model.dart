import 'package:ager_waffer/Base/network/network-mappers.dart';

class SendRequestModel extends BaseMappable {
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  SendRequestModel({
    this.isSuccess,
    this.data,
    this.messageAr,
    this.messageEn,
    this.statusCode,
  });

  SendRequestModel.fromJson(Map<String, dynamic> json) {
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
    return SendRequestModel(
      isSuccess: isSuccess,
      data: data,
      messageAr: messageAr,
      messageEn: messageEn,
      statusCode: statusCode,
    );
  }
}

class Data {
  int? rentalRequestId;
  int? itemId;
  List<String>? itemImages;
  String? itemCondition;
  String? itemName;
  double? itemRate;
  String? fromDate;
  String? toDate;
  String? renteeId;
  String? renteeName;
  String? governorate;
  String? city;
  String? street;
  String? phoneNumber;
  String? email;
  String? ownerId;
  String? ownerName;
  double? price;
  double? insurance;
  String? rentUnit;
  double? totalPrice;
  String? status;

  Data({
    this.rentalRequestId,
    this.itemId,
    this.itemImages,
    this.itemCondition,
    this.itemName,
    this.itemRate,
    this.fromDate,
    this.toDate,
    this.renteeId,
    this.renteeName,
    this.governorate,
    this.city,
    this.street,
    this.phoneNumber,
    this.email,
    this.ownerId,
    this.ownerName,
    this.price,
    this.insurance,
    this.rentUnit,
    this.totalPrice,
    this.status,
  });

  Data.fromJson(Map<String, dynamic> json) {
    rentalRequestId = json['rentalRequestId'];
    itemId = json['itemId'];
    itemImages = json['itemImages'].cast<String>();
    itemCondition = json['itemCondition'];
    itemName = json['itemName'];
    itemRate = json['itemRate'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    renteeId = json['renteeId'];
    renteeName = json['renteeName'];
    governorate = json['governorate'];
    city = json['city'];
    street = json['street'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    ownerId = json['ownerId'];
    ownerName = json['ownerName'];
    price = (json['price'] as num?)?.toDouble();
    insurance = (json['insurance'] as num?)?.toDouble();
    rentUnit = json['rentUnit'];
    totalPrice = (json['totalPrice'] as num?)?.toDouble();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rentalRequestId'] = this.rentalRequestId;
    data['itemId'] = this.itemId;
    data['itemImages'] = this.itemImages;
    data['itemCondition'] = this.itemCondition;
    data['itemName'] = this.itemName;
    data['itemRate'] = this.itemRate;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['renteeId'] = this.renteeId;
    data['renteeName'] = this.renteeName;
    data['governorate'] = this.governorate;
    data['city'] = this.city;
    data['street'] = this.street;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['ownerId'] = this.ownerId;
    data['ownerName'] = this.ownerName;
    data['price'] = this.price;
    data['insurance'] = this.insurance;
    data['rentUnit'] = this.rentUnit;
    data['totalPrice'] = this.totalPrice;
    data['status'] = this.status;
    return data;
  }
}
