import 'package:ager_waffer/Base/network/network-mappers.dart';

class AddReportModel extends BaseMappable {
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;

  AddReportModel({
    this.isSuccess,
    this.data,
    this.messageAr,
    this.messageEn,
    this.statusCode,
  });

  AddReportModel.fromJson(Map<String, dynamic> json) {
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
    return AddReportModel(
      isSuccess: isSuccess,
      data: data,
      messageAr: messageAr,
      messageEn: messageEn,
      statusCode: statusCode,
    );
  }
}

class Data {
  int? id;
  String? type;
  String? description;
  String? authorId;
  String? authorName;
  String? authorImageUrl;
  String? authorImagePublicId;
  String? createdAt;
  String? reportedUserId;
  String? reportedUserName;
  String? reportedUserEmail;

  Data({
    this.id,
    this.type,
    this.description,
    this.authorId,
    this.authorName,
    this.authorImageUrl,
    this.authorImagePublicId,
    this.createdAt,
    this.reportedUserId,
    this.reportedUserName,
    this.reportedUserEmail,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    description = json['description'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    authorImageUrl = json['authorImageUrl'];
    authorImagePublicId = json['authorImagePublicId'];
    createdAt = json['createdAt'];
    reportedUserId = json['reportedUserId'];
    reportedUserName = json['reportedUserName'];
    reportedUserEmail = json['reportedUserEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['description'] = this.description;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['authorImageUrl'] = this.authorImageUrl;
    data['authorImagePublicId'] = this.authorImagePublicId;
    data['createdAt'] = this.createdAt;
    data['reportedUserId'] = this.reportedUserId;
    data['reportedUserName'] = this.reportedUserName;
    data['reportedUserEmail'] = this.reportedUserEmail;
    return data;
  }
}
