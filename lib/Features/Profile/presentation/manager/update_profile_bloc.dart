import 'dart:io';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Features/Profile/data/repositories/update_profile_repository.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_profile_state.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/update_profile_model.dart';

class UpdateProfileBloc extends Bloc<AppEvent, UpdateProfileState> {
  UpdateProfileBloc()
      : super(UpdateProfileState(
    profileData: Data(),
    status: updateProfileStatus.initial,
  )) {
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event,
      Emitter<UpdateProfileState> emit,
      ) async {
    emit(state.copyWith(status: updateProfileStatus.loading));

    try {
      // 🔥 Debug مهم
      print("Updating profile...");
      print("FirstName: ${event.firstName}");
      print("LastName: ${event.lastName}");
      print("Phone: ${event.phone}");
      print("Password: ${event.password}");
      print("Image: ${event.profileImage?.path}");

      final response = await updateProfileRepository.updateProfile(
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        password: event.password,
        profileImage: event.profileImage, // Repository بيعالجها صح
      );


      if (response.isSuccess == true) {
        final currentUser = await sharedPreferenceManager.getUser();

        final updatedUser = currentUser?.copyWith(
          firstName: event.firstName,
          lastName: event.lastName,
          phoneNumber: event.phone ?? currentUser.phoneNumber,
          imageUrl: response.data?.imageUrl ?? currentUser.imageUrl,
        );

        if (updatedUser != null) {
          await sharedPreferenceManager.saveUser(updatedUser);
        }

        emit(state.copyWith(
          status: updateProfileStatus.success,
          profileData: response.data ?? Data(),
        ));
      } else {
        // 🔴 مهم جدًا
        emit(
          state.copyWith(
            status: updateProfileStatus.failure,
            failureMessage:
            response.messageAr ?? "فشل التحديث من السيرفر",
          ),
        );
      }
    } catch (e, stackTrace) {
      // 🔥 أهم Debug
      print("ERROR: $e");
      print("STACK: $stackTrace");

      emit(
        state.copyWith(
          status: updateProfileStatus.failure,
          failureMessage: e.toString(),
        ),
      );
    }
  }
}