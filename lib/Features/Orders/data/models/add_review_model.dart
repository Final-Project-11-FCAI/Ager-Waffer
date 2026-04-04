import 'package:ager_waffer/Base/network/network-mappers.dart';

class AddReviewModel extends BaseMappable {
  bool? isSuccess;
  Data? data;
  String? messageAr;
  String? messageEn;
  int? statusCode;
  Null? errors;

  AddReviewModel({
    this.isSuccess,
    this.data,
    this.messageAr,
    this.messageEn,
    this.statusCode,
    this.errors,
  });

  AddReviewModel.fromJson(Map<String, dynamic> json) {
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
    errors = json['errors'];

    return AddReviewModel(
      isSuccess: isSuccess,
      data: data,
      messageAr: messageAr,
      messageEn: messageEn,
      statusCode: statusCode,
      errors: errors,
    );
  }
}

class Data {
  int? id;
  String? reviewText;
  int? rate;
  String? createAt;
  int? reviewType;
  String? authorId;
  String? authorName;
  String? authorImageUrl;
  Null? reviewedUserId;
  Null? reviewedUserName;

  Data({
    this.id,
    this.reviewText,
    this.rate,
    this.createAt,
    this.reviewType,
    this.authorId,
    this.authorName,
    this.authorImageUrl,
    this.reviewedUserId,
    this.reviewedUserName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewText = json['reviewText'];
    rate = json['rate'];
    createAt = json['createAt'];
    reviewType = json['reviewType'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    authorImageUrl = json['authorImageUrl'];
    reviewedUserId = json['reviewedUserId'];
    reviewedUserName = json['reviewedUserName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reviewText'] = this.reviewText;
    data['rate'] = this.rate;
    data['createAt'] = this.createAt;
    data['reviewType'] = this.reviewType;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['authorImageUrl'] = this.authorImageUrl;
    data['reviewedUserId'] = this.reviewedUserId;
    data['reviewedUserName'] = this.reviewedUserName;
    return data;
  }
}
