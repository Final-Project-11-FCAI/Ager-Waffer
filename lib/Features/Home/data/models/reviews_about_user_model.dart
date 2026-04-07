// class ReviewsAboutUserModel {
//   bool? isSuccess;
//   List<Null>? data;
//   String? messageAr;
//   String? messageEn;
//   int? statusCode;
//   Null? errors;
//
//   ReviewsAboutUserModel(
//       {this.isSuccess,
//         this.data,
//         this.messageAr,
//         this.messageEn,
//         this.statusCode,
//         this.errors});
//
//   ReviewsAboutUserModel.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     if (json['data'] != null) {
//       data = <Null>[];
//       json['data'].forEach((v) {
//         data!.add(new Null.fromJson(v));
//       });
//     }
//     messageAr = json['messageAr'];
//     messageEn = json['messageEn'];
//     statusCode = json['statusCode'];
//     errors = json['errors'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isSuccess'] = this.isSuccess;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['messageAr'] = this.messageAr;
//     data['messageEn'] = this.messageEn;
//     data['statusCode'] = this.statusCode;
//     data['errors'] = this.errors;
//     return data;
//   }
// }