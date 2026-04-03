import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Profile/data/repositories/toggle_availability_repository.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/toggle_availability_state.dart';
import 'package:bloc/bloc.dart';

class ToggleAvailabilityBloc
    extends Bloc<AppEvent, ToggleAvailabilityState> {
  ToggleAvailabilityBloc()
      : super(ToggleAvailabilityState(
    isAvailable: false,
    status: toggleAvailabilityStatus.initial,
  )) {
    on<ToggleAvailabilityEvent>(_onToggleAvailability);
  }

  Future<void> _onToggleAvailability(
      ToggleAvailabilityEvent event,
      Emitter<ToggleAvailabilityState> emit,
      ) async {
    emit(state.copyWith(status: toggleAvailabilityStatus.loading));

    try {
      final response =
      await toggleAvailabilityRepository.toggleAvailability(
        id: event.id,
        isAvailable: event.isAvailable,
      );

      if (response.isSuccess == true) {
        emit(state.copyWith(
          status: toggleAvailabilityStatus.success,
          isAvailable: event.isAvailable,
        ));
      } else {
        emit(
          state.copyWith(
            status: toggleAvailabilityStatus.failure,
            failureMessage:
            response.messageAr ?? "فشل تغيير الحالة",
          ),
        );
      }
    } catch (e, stackTrace) {
      emit(
        state.copyWith(
          status: toggleAvailabilityStatus.failure,
          failureMessage: e.toString(),
        ),
      );
    }
  }
}