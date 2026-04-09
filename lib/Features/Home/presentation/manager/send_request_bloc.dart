import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Home/data/repositories/send_request_repository.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/send_request_state.dart';
import 'package:bloc/bloc.dart';


class SendRequestBloc extends Bloc<AppEvent, SendRequestState> {

  SendRequestBloc()
      : super(SendRequestState(
    rentalData: null,
    status: sendRequestStatus.initial,
  )) {
    on<SendRequestEvent>(_onSendRequest);
  }

  Future<void> _onSendRequest(
      SendRequestEvent event,
      Emitter<SendRequestState> emit) async {

    emit(state.copyWith(status: sendRequestStatus.loading));

    var response = await sendRequestRepository.sendRequest(
      sendRequestEntity: event.rentalRequestEntity,
    );

    if (response.isSuccess!) {
      emit(state.copyWith(
        status: sendRequestStatus.success,
        rentalData: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: sendRequestStatus.failure,
        failureMessage: response.messageAr,
      ));
    }
  }
}

SendRequestBloc sendRequestBloc = SendRequestBloc();