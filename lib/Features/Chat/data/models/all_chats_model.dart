import 'package:ager_waffer/Base/network/network-mappers.dart';

class AllChatsModel extends BaseMappable {
  bool? isSuccess;
  List<Data>? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;
  Null? errors;

  AllChatsModel({
    this.isSuccess,
    this.data,
    this.messageAr,
    this.messageEn,
    this.statusCode,
    this.errors,
  });

  AllChatsModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
    statusCode = json['statusCode'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    messageAr = json['messageAr'];
    messageEn = json['messageEn'];
    statusCode = json['statusCode'];
    errors = json['errors'];

    return AllChatsModel(
      data: data,
      isSuccess: isSuccess,
      messageAr: messageAr,
      messageEn: messageEn,
      statusCode: statusCode,
      errors: errors,
    );
  }
}

class Data {
  String? userId;
  String? username;
  String? profileImage;
  String? lastMessageContent;
  int? lastMessageType;
  String? lastMessageAt;
  int? unreadCount;

  Data({
    this.userId,
    this.username,
    this.profileImage,
    this.lastMessageContent,
    this.lastMessageType,
    this.lastMessageAt,
    this.unreadCount,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    profileImage = json['profileImage'];
    lastMessageContent = json['lastMessageContent'];
    lastMessageType = json['lastMessageType'];
    lastMessageAt = json['lastMessageAt'];
    unreadCount = json['unreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['profileImage'] = this.profileImage;
    data['lastMessageContent'] = this.lastMessageContent;
    data['lastMessageType'] = this.lastMessageType;
    data['lastMessageAt'] = this.lastMessageAt;
    data['unreadCount'] = this.unreadCount;
    return data;
  }
}
