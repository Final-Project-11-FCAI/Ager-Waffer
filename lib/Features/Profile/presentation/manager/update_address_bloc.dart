import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Profile/data/repositories/update_address_repository.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/update_address_state.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/update_address_model.dart';

class UpdateAddressBloc extends Bloc<AppEvent, UpdateAddressState> {

  UpdateAddressBloc()
      : super(UpdateAddressState(addressData: Data(), status: updateAddressStatus.initial,)) {
    on<UpdateAddressEvent>(_onUpdateAddress);
  }

  Future<void> _onUpdateAddress(
      UpdateAddressEvent event,
      Emitter<UpdateAddressState> emit,
      ) async {

    emit(state.copyWith(status: updateAddressStatus.loading));

    try {
      final response = await updateAddressRepository.updateAddress(
        city: event.city,
        street: event.street,
        governorate: event.governorate,
        phoneNumber: event.phoneNumber,
      );

      if (response.isSuccess == true) {
        emit(state.copyWith(
          status: updateAddressStatus.success,
          addressData: response.data,
        ));
      } else {
        emit(state.copyWith(
          status: updateAddressStatus.failure,
          failureMessage: response.messageAr ??
              response.messageEn ??
              kUpdateError.tr(),
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: updateAddressStatus.failure,
        failureMessage: kUpdateError.tr(),
      ));
    }
  }
}