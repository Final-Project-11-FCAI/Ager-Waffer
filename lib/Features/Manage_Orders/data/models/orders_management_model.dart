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
  String? renteeName;
  String? renteeId;
  String? fromDate;
  String? toDate;
  double? totalPrice;
  int? timeLeftInDays;
  String? status;

  OrderManagementData({
    this.requestId,
    this.itemId,
    this.itemImages,
    this.itemName,
    this.renteeName,
    this.renteeId,
    this.fromDate,
    this.toDate,
    this.totalPrice,
    this.timeLeftInDays,
    this.status,
  });

  OrderManagementData.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    itemId = json['itemId'];
    itemImages = json['itemImages'].cast<String>();
    itemName = json['itemName'];
    renteeName = json['renteeName'];
    renteeId = json['renteeId'];
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
    data['renteeName'] = this.renteeName;
    data['renteeId'] = this.renteeId;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['totalPrice'] = this.totalPrice;
    data['timeLeftInDays'] = this.timeLeftInDays;
    data['status'] = this.status;
    return data;
  }
}
