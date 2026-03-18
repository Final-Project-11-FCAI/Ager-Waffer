import 'package:ager_waffer/Base/network/network-mappers.dart';

class LoginModel extends BaseMappable{
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;
  Null? errors;

  LoginModel(
      {this.isSuccess,
        this.data,
        this.messageAr,
        this.messageEn,
        this.statusCode,
        this.errors});

  LoginModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
    statusCode = json['statusCode'];
    errors = json['errors'];
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
    data['errors'] = this.errors;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
    statusCode = json['statusCode'];
    if(json['errors'] != null)
    errors = json['errors'].cast<String>();
    return LoginModel(isSuccess: isSuccess,data: data,messageAr: messageAr,messageEn: messageEn, statusCode: statusCode, errors: errors);
  }
}

class Data {
  String? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? city;
  String? street;
  String? governorate;
  String? imageUrl;
  String? imagePublicId;
  String? token;
  String? tokenExpirey;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.fullName,
        this.email,
        this.phoneNumber,
        this.city,
        this.street,
        this.governorate,
        this.imageUrl,
        this.imagePublicId,
        this.token,
        this.tokenExpirey});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    street = json['street'];
    governorate = json['governorate'];
    imageUrl = json['imageUrl'];
    imagePublicId = json['imagePublicId'];
    token = json['token'];
    tokenExpirey = json['tokenExpirey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['city'] = this.city;
    data['street'] = this.street;
    data['governorate'] = this.governorate;
    data['imageUrl'] = this.imageUrl;
    data['imagePublicId'] = this.imagePublicId;
    data['token'] = this.token;
    data['tokenExpirey'] = this.tokenExpirey;
    return data;
  }
}