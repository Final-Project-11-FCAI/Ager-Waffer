import 'dart:io';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Home/data/repositories/owner_rental_count_repository.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/owner_rental_count_state.dart';
import 'package:bloc/bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OwnerRentalCountBloc
    extends Bloc<AppEvent, OwnerRentalCountState> {

  OwnerRentalCountBloc()
      : super(const OwnerRentalCountState(
    count: 0,
    status: ownerRentalCountStatus.initial,
  )) {
    on<GetOwnerRentalCountEvent>(_onGetOwnerRentalCount);
  }

  Future<void> _onGetOwnerRentalCount(
      GetOwnerRentalCountEvent event,
      Emitter<OwnerRentalCountState> emit,
      ) async {

    emit(state.copyWith(
      status: ownerRentalCountStatus.loading,
      failureMessage: '',
    ));

    try {
      final response =
      await ownerRentalCountRepository.getOwnerRentalCount();

      if (response.isSuccess == true) {
        emit(state.copyWith(
          status: ownerRentalCountStatus.success,
          count: response.data ?? 0,
          failureMessage: '',
        ));
      } else {
        emit(state.copyWith(
          status: ownerRentalCountStatus.failure,
          failureMessage: response.messageAr ?? kSomethingWrong.tr(),
          count: 0,
        ));
      }
    }

    catch (e) {
      print("ERROR: $e");

      String message = kUnexpectedError.tr();

      if (e is SocketException ||
          e.toString().contains("Network is unreachable")) {
        message = kNoInternet.tr();
      }

      emit(state.copyWith(
        status: ownerRentalCountStatus.failure,
        failureMessage: message,
        count: 0,
      ));
    }
  }
}

OwnerRentalCountBloc ownerRentalCountBloc = OwnerRentalCountBloc();