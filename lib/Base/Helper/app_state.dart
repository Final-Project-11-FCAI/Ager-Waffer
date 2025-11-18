

import '../network/network-mappers.dart';

abstract class AppState {
  get model =>null;
}
class Start extends AppState{
}


// // LOGIN
// class LoginLoading extends AppState{}
//
// class LoginDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   LoginDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class LoginErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   LoginErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //REGISTER
// class RegisterLoading extends AppState{}
//
// class RegisterDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   RegisterDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class RegisterErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   RegisterErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //VERIFY OTP
// class VerifyOtpLoading extends AppState{}
//
// class VerifyOtpDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   VerifyOtpDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class VerifyOtpErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   VerifyOtpErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //RESEND OTP
// class ResendOtpLoading extends AppState{}
//
// class ResendOtpDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   ResendOtpDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class ResendOtpErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   ResendOtpErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// //REFRESH TOKEN
// class RefreshTokenLoading extends AppState{}
//
// class RefreshTokenDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   RefreshTokenDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class RefreshTokenErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   RefreshTokenErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// //REFRESH TOKEN
// class LogoutLoading extends AppState{}
//
// class LogoutDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   LogoutDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class LogoutErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   LogoutErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// // ListAllAdvertisements
// class AdvertisementsLoading extends AppState{}
//
// class AdvertisementsDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   AdvertisementsDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class AdvertisementsErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   AdvertisementsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// // MAIN DEPARTMENTS
// class MainDepartmentsLoading extends AppState{}
//
// class MainDepartmentsDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   MainDepartmentsDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class MainDepartmentsErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   MainDepartmentsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// // DEPARTMENTS
// class DepartmentsLoading extends AppState{}
//
// class DepartmentsDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   DepartmentsDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class DepartmentsErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   DepartmentsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// // Categories
// class CategoriesLoading extends AppState{}
//
// class CategoriesDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   CategoriesDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class CategoriesErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   CategoriesErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// //POPULAR SERVICES
// class PopularServicesLoading extends AppState{}
//
// class PopularServicesDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   PopularServicesDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class PopularServicesErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   PopularServicesErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// //CURRENT ORDER
//
// class DeliveryScheduleLoading extends AppState{}
//
// class DeliveryScheduleDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   DeliveryScheduleDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
// }
//
// class DeliveryScheduleErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   DeliveryScheduleErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
// }
//
//
// class CurrentOrderLoading extends AppState{}
//
// class CurrentOrderDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   CurrentOrderDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class CurrentOrderErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   CurrentOrderErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //LIST ORDERS
// class OrdersByStatusLoading extends AppState{}
//
// class OrdersByStatusDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   OrdersByStatusDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class OrdersByStatusErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   OrdersByStatusErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //DRAFT ORDERS
// class DraftOrdersLoading extends AppState{}
//
// class DraftOrdersDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   DraftOrdersDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class DraftOrdersErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   DraftOrdersErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //TRACK ORDERS
// class OrderTrackLoading extends AppState{}
//
// class OrderTrackDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   OrderTrackDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class OrderTrackErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   OrderTrackErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// // ORDER DETAILS
// class OrderDetailsLoading extends AppState{}
//
// class OrderDetailsDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   OrderDetailsDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class OrderDetailsErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   OrderDetailsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //CREATE ORDER
// class CreateOrderLoading extends AppState{}
//
// class CreateOrderDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   CreateOrderDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class CreateOrderErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   CreateOrderErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
// }
//
// //TOW TRUCK ORDER
// class SelectTowTruckOrderLoading extends AppState{}
//
// class SelectTowTruckOrderDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   SelectTowTruckOrderDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class SelectTowTruckOrderErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   SelectTowTruckOrderErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
// }
//
//
// //CREATE ORDER
// class CreateDraftOrderLoading extends AppState{}
//
// class CreateDraftOrderDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   CreateDraftOrderDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class CreateDraftOrderErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   CreateDraftOrderErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //DELETE ORDER
// class DeleteDraftOrderLoading extends AppState{}
//
// class DeleteDraftOrderDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   DeleteDraftOrderDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class DeleteDraftOrderErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   DeleteDraftOrderErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //FILTER ORDER
// class FilterOrderLoading extends AppState{}
//
// class FilterOrderDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   FilterOrderDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class FilterOrderErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   FilterOrderErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //LOCATIONS
// class GetUserLocationLoading extends AppState{}
//
// class GetUserLocationDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   GetUserLocationDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class GetUserLocationErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   GetUserLocationErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// //ADD LOCATIONS
// class AddUserLocationLoading extends AppState{}
//
// class AddUserLocationDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   AddUserLocationDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class AddUserLocationErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   AddUserLocationErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// //EDIT LOCATIONS
// class EditUserLocationLoading extends AppState{}
//
// class EditUserLocationDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   EditUserLocationDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class EditUserLocationErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   EditUserLocationErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
//
// //ADD LOCATIONS
// class DeleteUserLocationLoading extends AppState{}
//
// class DeleteUserLocationDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   DeleteUserLocationDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class DeleteUserLocationErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   DeleteUserLocationErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// //ADD LOCATIONS
// class SetDefaultUserLocationLoading extends AppState{}
//
// class SetDefaultUserLocationDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   SetDefaultUserLocationDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class SetDefaultUserLocationErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   SetDefaultUserLocationErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
// class MyCarStart extends MyCarState{
// }
//
// //CAR BRANDS
// class CarBrandLoading extends MyCarState{}
//
// class CarBrandDoneState extends MyCarState{
//   Mappable? model;
//   final String? indicator;
//   CarBrandDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class CarBrandErrorLoadingState extends MyCarState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   CarBrandErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// //CAR Models
// class CarModelsLoading extends MyCarState{}
//
// class CarModelsDoneState extends MyCarState{
//   Mappable? model;
//   final String? indicator;
//   CarModelsDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class CarModelsErrorLoadingState extends MyCarState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   CarModelsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// //MY CARS
// class MyCarsLoading extends MyCarState{}
//
// class MyCarsDoneState extends MyCarState{
//   Mappable? model;
//   final String? indicator;
//   MyCarsDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class MyCarsErrorLoadingState extends MyCarState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   MyCarsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //ADD CARS
// class AddUserCarLoading extends MyCarState{}
//
// class AddUserCarDoneState extends MyCarState{
//   Mappable? model;
//   final String? indicator;
//   AddUserCarDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class AddUserCarErrorLoadingState extends MyCarState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   AddUserCarErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //EDIT CARS
// class EditUserCarLoading extends MyCarState{}
//
// class EditUserCarDoneState extends MyCarState{
//   Mappable? model;
//   final String? indicator;
//   EditUserCarDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class EditUserCarErrorLoadingState extends MyCarState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   EditUserCarErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// // DELETE CAR
// class DeleteCarLoading extends MyCarState{}
//
// class DeleteCarDoneState extends MyCarState{
//   Mappable? model;
//   final String? indicator;
//   DeleteCarDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class DeleteCarErrorLoadingState extends MyCarState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   DeleteCarErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// // SET DEFAULT CAR
// class SetDefaultCarLoading extends MyCarState{}
//
// class SetDefaultCarDoneState extends MyCarState{
//   Mappable? model;
//   final String? indicator;
//   SetDefaultCarDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class SetDefaultCarErrorLoadingState extends MyCarState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   SetDefaultCarErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// // EDIT CAR
// class EditCarLoading extends AppState{}
//
// class EditCarDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   EditCarDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class EditCarErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   EditCarErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
//
// // NOTIFICATIONS
// class GetNotificationsLoading extends AppState{}
//
// class GetNotificationsDoneState extends AppState{
//   final List<Notification>? notifications;
//   final bool hasMore;
//   GetNotificationsDoneState({this.notifications , this.hasMore = false});
//
// }
//
// class GetNotificationsErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   GetNotificationsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// // READ NOTIFICATIONS
// class ReadNotificationsLoading extends AppState{}
//
// class ReadNotificationsDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   ReadNotificationsDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class ReadNotificationsErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   ReadNotificationsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// // DELETE NOTIFICATIONS
// class DeleteNotificationsLoading extends AppState{}
//
// class DeleteNotificationsDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   DeleteNotificationsDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class DeleteNotificationsErrorLoadingState extends AppState {
//   Mappable? model;
//   String? indicator;
//   String? message;
//
//   DeleteNotificationsErrorLoadingState(
//       {this.model, this.message, this.indicator});
//
//   @override
//   String toString() {
//     return message!;
//   }
// }
//   class SelectedCarBransDoneState extends MyCarState{
//   final int? brandId;
//   final String? brandName;
//   SelectedCarBransDoneState({this.brandId , this.brandName});
//   }
//
//   //Upload Images
// class UploadCarImagesLoading extends MyCarState{}
//
// class  UploadCarImagesDoneState extends MyCarState{
//   Mappable? model;
//   final String? indicator;
//   UploadCarImagesDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class  UploadCarImagesErrorLoadingState extends MyCarState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   UploadCarImagesErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// class UploadCarFormLoading extends MyCarState{}
//
// class  UploadCarFormDoneState extends MyCarState{
//   Mappable? model;
//   final String? indicator;
//   UploadCarFormDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class  UploadCarFormErrorLoadingState extends MyCarState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   UploadCarFormErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
// }
//
//
// //PROFILE
//
// class GetProfileUserDataLoading extends AppState{}
//
// class GetProfileUserDataDoneState extends AppState{
//   Mappable? model;
//   GetProfileUserDataDoneState({this.model });
//
// }
//
// class GetProfileUserDataErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   GetProfileUserDataErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// class GetProfileUserStatisticsLoading extends AppState{}
//
// class GetProfileUserStatisticsDoneState extends AppState{
//   Mappable? model;
//   GetProfileUserStatisticsDoneState({this.model });
//
// }
//
// class GetProfileUserStatisticsErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   GetProfileUserStatisticsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// class EditProfileLoading extends AppState{}
//
// class EditProfileDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   EditProfileDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class EditProfileErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   EditProfileErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// class EditProfileImageLoading extends AppState{}
//
// class EditProfileImageDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   EditProfileImageDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class EditProfileImageErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   EditProfileImageErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// //UPLOAD PROFILE IMAGE
// class UploadProfileImageLoading extends AppState{}
//
// class  UploadProfileImageDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   UploadProfileImageDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class  UploadProfileImageErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   UploadProfileImageErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
// }
//
// // SERVICES
// class ServicesLoading extends AppState{}
//
// class ServicesDoneState extends AppState{
//   List<Service>? services;
//   final String? indicator;
//   ServicesDoneState({this.services , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class ServicesErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   ServicesErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
//
// // PROVIDERS
// class ProvidersLoading extends AppState{}
//
// class ProvidersDoneState extends AppState{
//   List<Provider>? providers;
//   final String? indicator;
//   ProvidersDoneState({this.providers , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class ProvidersErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   ProvidersErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
//
// class ProvidersWorkingHoursLoading extends AppState{}
//
// class ProvidersWorkingHoursDoneState extends AppState{
//   List<WorkingHour>? workingHours;
//   final String? indicator;
//   ProvidersWorkingHoursDoneState({this.workingHours , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class ProvidersWorkingHoursErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   ProvidersWorkingHoursErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
//
// }
//
// // SPARE PARTS
// class SparePartsLoading extends AppState{}
//
// class SparePartsDoneState extends AppState{
//   List<SparePart>? spareParts;
//   final String? indicator;
//   SparePartsDoneState({this.spareParts , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
//
// }
//
// class SparePartsErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   SparePartsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
// }
// // GET DRIVER DATA
// class GetDriverDetailsLoading extends AppState{}
//
// class GetDriverDetailsDoneState extends AppState{
//   Mappable? model;
//   final String? indicator;
//   GetDriverDetailsDoneState({this.model , this.indicator});
//
//   @override
//   String toString() {
//     return indicator!;
//   }
// }
//
// class GetDriverDetailsErrorLoadingState extends AppState{
//   Mappable? model;
//   String? indicator;
//   String? message;
//   GetDriverDetailsErrorLoadingState({this.model,this.message,this.indicator});
//   @override
//   String toString() {
//     return message!;
//   }
// }
