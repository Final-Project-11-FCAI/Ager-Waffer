import 'package:ager_waffer/Base/network/network-mappers.dart';

class MyOrdersModel extends BaseMappable {
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  MyOrdersModel({
    this.isSuccess,
    this.data,
    this.messageAr,
    this.messageEn,
    this.statusCode,
  });

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
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
    return MyOrdersModel(
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
  List<OrderData>? data;

  Data({this.pageIndex, this.pageSize, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    count = json['count'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(new OrderData.fromJson(v));
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

class OrderData {
  int? requestId;
  int? itemId;
  List<String>? itemImages;
  String? itemName;
  String? ownerName;
  String? ownerId;
  String? fromDate;
  String? toDate;
  double? totalPrice;
  Null? timeLeftInDays;
  String? status;

  OrderData({
    this.requestId,
    this.itemId,
    this.itemImages,
    this.itemName,
    this.ownerName,
    this.ownerId,
    this.fromDate,
    this.toDate,
    this.totalPrice,
    this.timeLeftInDays,
    this.status,
  });

  OrderData.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    itemId = json['itemId'];
    itemImages = json['itemImages'].cast<String>();
    itemName = json['itemName'];
    ownerName = json['ownerName'];
    ownerId = json['ownerId'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    totalPrice = (json['totalPrice'] as num?)?.toDouble();
    timeLeftInDays = json['timeLeftInDays'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['itemId'] = this.itemId;
    data['itemImages'] = this.itemImages;
    data['itemName'] = this.itemName;
    data['ownerName'] = this.ownerName;
    data['ownerId'] = this.ownerId;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['totalPrice'] = this.totalPrice;
    data['timeLeftInDays'] = this.timeLeftInDays;
    data['status'] = this.status;
    return data;
  }
}
