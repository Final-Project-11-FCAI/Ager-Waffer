import 'dart:io';

import 'package:ager_waffer/Features/Authentication/login/domain/entities/register_entity.dart';
import 'package:ager_waffer/Features/Home/domain/entities/add_item_entity.dart';
import 'package:ager_waffer/Features/Home/domain/entities/send_request_entity.dart';
import 'package:image_picker/image_picker.dart';


abstract class AppEvent {}

class LoginEvent extends AppEvent{
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password,});
}


class RegisterEvent extends AppEvent{
  final RegisterEntity registerEntity;
  RegisterEvent({required this.registerEntity});
}


class ForgetPasswordEvent extends AppEvent{
  final String email;
  ForgetPasswordEvent({required this.email,});
}


class VerifyOtpEvent extends AppEvent{
  final String email;
  final String otp;
  VerifyOtpEvent({required this.email, required this.otp,});
}

class ResetPasswordEvent extends AppEvent{
  final String email;
  final String newPassword;
  ResetPasswordEvent({required this.email, required this.newPassword,});
}

class GetAllItemsEvent extends AppEvent{
  GetAllItemsEvent();
}

class AddItemEvent extends AppEvent{
  final AddItemEntity addItemEntity;
  AddItemEvent({required this.addItemEntity});
}

class GetMyListingsEvent extends AppEvent{
  GetMyListingsEvent();
}

class DeleteItemEvent extends AppEvent {
  final int productId;

  DeleteItemEvent({required this.productId});
}


class UpdateItemEvent extends AppEvent {
  final int productId;
  final AddItemEntity addItemEntity;

  UpdateItemEvent({
    required this.productId,
    required this.addItemEntity,
  });
}

class UpdateProfileEvent extends AppEvent {
  final String firstName;
  final String lastName;
  final String? phone;
  final String? password;
  final XFile? profileImage;

  UpdateProfileEvent({
    required this.firstName,
    required this.lastName,
    this.phone,
    this.password,
    this.profileImage,
  });
}

class ToggleAvailabilityEvent extends AppEvent {
  final int id;
  final bool isAvailable;

  ToggleAvailabilityEvent({
    required this.id,
    required this.isAvailable,
  });
}


class AddReviewEvent extends AppEvent {
  final int reviewType;
  final int itemId;
  final String? reviewedUserId;
  final String reviewText;
  final int rate;

  AddReviewEvent({
    required this.reviewType,
    required this.itemId,
    this.reviewedUserId,
    required this.reviewText,
    required this.rate,
  });
}


class GetItemReviewEvent extends AppEvent {
  final int itemId;

  GetItemReviewEvent({required this.itemId});
}


class UpdateAddressEvent extends AppEvent {
  final String city;
  final String street;
  final String governorate;
  final String phoneNumber;

  UpdateAddressEvent({
    required this.city,
    required this.street,
    required this.governorate,
    required this.phoneNumber,
  });
}

class ExternalLoginEvent extends AppEvent {
  final String provider; // google or facebook
  final String accessToken;

  ExternalLoginEvent({
    required this.provider,
    required this.accessToken,
  });
}


//Orders Events

class SendRequestEvent extends AppEvent {
  final SendRequestEntity rentalRequestEntity;

  SendRequestEvent({required this.rentalRequestEntity});
}

class GetMyOrdersEvent extends AppEvent {
  GetMyOrdersEvent();
}



//Chats Events
class GetAllChatsEvent extends AppEvent {
  GetAllChatsEvent();
}

class GetMessagesEvent extends AppEvent {
  final String conversationId;

  GetMessagesEvent({required this.conversationId});
}







// class VerifyOtpEvent extends AppEvent{
//   final OtpEntity otpEntity;
//   VerifyOtpEvent({required this.otpEntity});
// }
//
// class ResendOtpEvent extends AppEvent{
//   final int id;
//   ResendOtpEvent({required this.id});
// }
// class RefreshTokenEvent extends AppEvent{
//   final String refreshToken;
//   RefreshTokenEvent({required this.refreshToken});
// }
//
// class LogoutEvent extends AppEvent{
//   final String token;
//   LogoutEvent({required this.token});
// }
//
// //HOME
// class AllAdvertisementsEvent extends AppEvent{
//   AllAdvertisementsEvent();
// }
//
// //DEPARTMENTS
// class GetMainDepartmentsEvent extends AppEvent{
//   GetMainDepartmentsEvent();
// }
// class GetDepartmentsEvent extends AppEvent{
//   final String maintanceId;
//   GetDepartmentsEvent({required this.maintanceId});
// }
//
// class GetCategoriesEvent extends AppEvent{
//   final String departmentId;
//   GetCategoriesEvent({required this.departmentId});
// }
//
// //POPULAR SERVICES
// class GetPopularServicesEvent extends AppEvent{
//   GetPopularServicesEvent();
// }
//
// //SERVICES
// class GetServicesEvent extends AppEvent{
//   GetServicesEvent();
// }
//
//   //SPARE PARTS
// class GetSparePartsEvent extends AppEvent{
//   final int serviceId;
//   GetSparePartsEvent({required this.serviceId});
// }
//
// //PROVIDERS
// class GetProvidersEvent extends AppEvent{
//   GetProvidersEvent();
// }
// class GetProviderWorkingHours extends AppEvent{
//   final String dayDate;
//   GetProviderWorkingHours({required this.dayDate});
// }
// // ORDER
// class DeliveryScheduleEvent extends AppEvent{
//   bool isPaid ;
//   DeliveryScheduleEvent({required this.isPaid});
// }
//
// class GetCurrentOrderEvent extends AppEvent{
//   GetCurrentOrderEvent();
// }
//
// class GetDriverDetailsEvent extends AppEvent{
//   final String driverId;
//   GetDriverDetailsEvent({required this.driverId});
// }
// class CreateOrderEvent extends AppEvent{
//   CreateOrderEvent();
// }
//
// class SelectTowTruckOrderEvent extends AppEvent{
//   SelectTowTruckOrderEvent();
// }
//
// class CreateDraftOrderEvent extends AppEvent{
//   CreateDraftOrderEvent();
// }
// class DeleteDraftOrderEvent extends AppEvent{
//   final int draftOrderId;
//   DeleteDraftOrderEvent({required this.draftOrderId});
// }
// class GetOrdersByStatusEvent extends AppEvent{
//   final ListOrderEntity  listOrderEntity;
//
//   GetOrdersByStatusEvent({required this.listOrderEntity});
// }
//
// class GetOrderTrackEvent extends AppEvent {}
//
// class GetOrderDetailsEvent extends AppEvent {}
//
// class OrderFilterationEvent extends AppEvent {}
//
// class GetDraftOrdersEvent extends AppEvent {}
//
//
//
// class FetchHomeDataEvent extends AppEvent {}
//
// //LOCATION
// class GetUserLocationEvent extends AppEvent{
//   GetUserLocationEvent();
// }
//
// class AddUserLocationEvent extends AppEvent{
//   LocationEntity? locationEntity;
//   AddUserLocationEvent({this.locationEntity});
// }
// class EditUserLocationEvent extends AppEvent{
//   LocationEntity? locationEntity;
//   EditUserLocationEvent({this.locationEntity});
// }
// class DeleteUserLocationEvent extends AppEvent{
//   LocationEntity? locationEntity;
//   DeleteUserLocationEvent({this.locationEntity});
// }
// class SetDefaultUserLocationEvent extends AppEvent{
//   LocationEntity? locationEntity;
//   SetDefaultUserLocationEvent({this.locationEntity});
// }
//
// //MY CARS
//
// class GetAllBrandsEvent extends AppEvent{}
//
// class GetAllCarModelsEvent extends AppEvent{
//   final String brandId;
//   GetAllCarModelsEvent({required this.brandId});
// }
//
// class GetMyCarsEvent extends AppEvent{
//   GetMyCarsEvent();
// }
//
// class DeleteUserCarEvent extends AppEvent{
//   int? carId;
//   DeleteUserCarEvent({this.carId});
// }
// class SetDefaultUserCarEvent extends AppEvent{
//   int? carId;
//   SetDefaultUserCarEvent({this.carId});
// }
//
// class AddUserCarEvent extends AppEvent{
//   AddUserCarEvent();
// }
// class EditUserCarEvent extends AppEvent{
//   CarEntity? editCarEntity;
//   EditUserCarEvent({this.editCarEntity});
// }
// class SelectCarBrandEvent extends AppEvent {
//   final int? brandId;
//   final String? brandName;
//
//   SelectCarBrandEvent({this.brandId, this.brandName});
// }
//
// class SelectCarModelEvent extends AppEvent {
//   final String? modelName;
//
//   SelectCarModelEvent({this.modelName});
// }
//
// //NOTIFICATIONS
// class GetNotificationsEvent extends AppEvent{
//   GetNotificationsEvent();
// }
//
// class ReadNotificationsEvent extends AppEvent{
//   NotificationRequestEntity notificationRequestEntity;
//   ReadNotificationsEvent({required this.notificationRequestEntity});
// }
//
// class DeleteNotificationsEvent extends AppEvent{
//   NotificationRequestEntity notificationRequestEntity;
//   DeleteNotificationsEvent({required this.notificationRequestEntity});
// }
//
// //UPLOAD IMAGES
//
// class UploadCarImagesEvent extends AppEvent{
//   List<File> images;
//   UploadCarImagesEvent({required this.images});
// }
//
// class UploadCarFormImageEvent extends AppEvent{
//   File formImage;
//   UploadCarFormImageEvent({required this.formImage});
// }
//
// //PROFILE
// class GetProfileUserDataEvent extends AppEvent{
//   GetProfileUserDataEvent();
// }
//
// class GetProfileUserStatisticsEvent extends AppEvent{
//   GetProfileUserStatisticsEvent();
// }
//
// class EditProfileEvent extends AppEvent{
//   ProfileEntity editProfileEntity;
//   EditProfileEvent({required this.editProfileEntity});
// }
//
// class EditProfileImageEvent extends AppEvent{
//   String imageUrl;
//   EditProfileImageEvent({required this.imageUrl});
// }
// class UploadProfileImageEvent extends AppEvent{
//   File profileImage;
//   UploadProfileImageEvent({required this.profileImage});
// }