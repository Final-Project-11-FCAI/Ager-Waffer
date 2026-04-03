import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Features/Profile/data/repositories/update_profile_repository.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_profile_state.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/update_profile_model.dart';

class UpdateProfileBloc extends Bloc<AppEvent, UpdateProfileState> {

  UpdateProfileBloc()
      : super(UpdateProfileState(profileData: Data(), status: updateProfileStatus.initial)) {
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event,
      Emitter<UpdateProfileState> emit) async {

    emit(state.copyWith(status: updateProfileStatus.loading));

    try {
      final response = await updateProfileRepository.updateProfile(
        firstName: event.firstName,
        lastName: event.lastName,
        phone: event.phone,
        password: event.password,
        profileImage: event.profileImage,
      );

      if (response.isSuccess == true) {
        final currentUser = await sharedPreferenceManager.getUser();

        final updatedUser = currentUser?.copyWith(
          firstName: event.firstName,
          lastName: event.lastName,
          phoneNumber: event.phone,
        ) ?? currentUser;

        if (updatedUser != null) {
          await sharedPreferenceManager.saveUser(updatedUser);
        }

        emit(state.copyWith(
          status: updateProfileStatus.success,
          profileData: response.data ?? Data(),
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: updateProfileStatus.failure,
        failureMessage: 'حدث خطأ أثناء التحديث',
      ));
    }
  }
}

UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();