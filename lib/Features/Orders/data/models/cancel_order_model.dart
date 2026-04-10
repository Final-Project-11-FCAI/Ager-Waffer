import 'package:ager_waffer/Base/network/network-mappers.dart';

class CancelOrderModel extends BaseMappable {
  bool? isSuccess;
  bool? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  CancelOrderModel({
    this.isSuccess,
    this.data,
    this.messageAr,
    this.messageEn,
    this.statusCode,
  });

  CancelOrderModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'];
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['data'] = this.data;
    data['messageAr'] = this.messageAr;
    data['messageEn'] = this.messageEn;
    data['statusCode'] = this.statusCode;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'];
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
    statusCode = json['statusCode'];
    return CancelOrderModel(
      data: data,
      isSuccess: isSuccess,
      messageAr: messageAr,
      messageEn: messageEn,
      statusCode: statusCode,
    );
  }
}
