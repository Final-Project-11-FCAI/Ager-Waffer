import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/external_login_state.dart';
import 'package:bloc/bloc.dart';

import '../../../../../Base/common/shared_preference_manger.dart';
import '../../data/repositories/external_login_repository.dart';

class ExternalLoginBloc extends Bloc<AppEvent, ExternalLoginState> {
  ExternalLoginBloc()
    : super(const ExternalLoginState(status: externalLoginStatus.initial)) {
    on<ExternalLoginEvent>(_onExternalLogin);
  }

  Future<void> _onExternalLogin(
    ExternalLoginEvent event,
    Emitter<ExternalLoginState> emit,
  ) async {
    emit(state.copyWith(status: externalLoginStatus.loading));

    try {
      var response = await ExternalLoginRepository().externalLogin(
        provider: event.provider,
        accessToken: event.accessToken,
      );

      if (response.isSuccess!) {
        sharedPreferenceManager.writeData(
          CachingKey.AUTH_TOKEN,
          response.data?.token,
        );

        sharedPreferenceManager.saveUser(response.data!);

        emit(
          state.copyWith(
            status: externalLoginStatus.success,
            user: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: externalLoginStatus.failure,
            failureMessage: response.messageAr,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: externalLoginStatus.failure,
          failureMessage: e.toString(),
        ),
      );
    }
  }
}

ExternalLoginBloc externalLoginBloc = ExternalLoginBloc();
