import 'dart:convert';

import 'package:ager_waffer/Base/network/network-mappers.dart';

class LoginModel extends BaseMappable{
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  LoginModel(
      {this.isSuccess,
        this.data,
        this.messageAr,
        this.messageEn,
        this.statusCode,
        });

  LoginModel.fromJson(Map<String, dynamic> json) {
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
    return LoginModel(isSuccess: isSuccess,data: data,messageAr: messageAr,messageEn: messageEn, statusCode: statusCode,);
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

  Data copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? city,
    String? street,
    String? governorate,
    String? imageUrl,
    String? imagePublicId,
    String? token,
    String? tokenExpirey,
  }) {
    return Data(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      street: street ?? this.street,
      governorate: governorate ?? this.governorate,
      imageUrl: imageUrl ?? this.imageUrl,
      imagePublicId: imagePublicId ?? this.imagePublicId,
      token: token ?? this.token,
      tokenExpirey: tokenExpirey ?? this.tokenExpirey,
    );
  }

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'street': street,
      'governorate': governorate,
      'imageUrl': imageUrl,
      'imagePublicId': imagePublicId,
      'token': token,
      'tokenExpirey': tokenExpirey
    };
  }

  // Convert Map to object
  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
        id: map['id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        fullName: map['fullName'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        city: map['city'],
        street: map['street'],
        governorate: map['governorate'],
        imageUrl: map['imageUrl'],
        imagePublicId: map['imagePublicId'],
        token: map['token'],
        tokenExpirey: map['tokenExpirey'],
    );
  }

  // Convert object to JSON string
  String toUserJson() => json.encode(toMap());

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