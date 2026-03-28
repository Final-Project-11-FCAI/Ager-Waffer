import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:ager_waffer/Features/Authentication/login/presentation/manager/login_state.dart';
import 'package:bloc/bloc.dart';

import '../../../../../Base/common/shared_preference_manger.dart';
import '../../data/repositories/authentication_repository.dart';

class LoginBloc extends Bloc<AppEvent , LoginState> {

  LoginBloc() :super(LoginState(user: Data(), status: loginStatus.initial)){
    on<LoginEvent>(_onLogin);

  }

  Future<void> _onLogin(LoginEvent event,
      Emitter<LoginState> emit) async {
    emit(state.copyWith(status: loginStatus.loading));
    var response = await authenticationRepository.login(
      email: event.email, password: event.password,
    );

    if (response.isSuccess! ) {
      sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data?.token);
      sharedPreferenceManager.writeData(CachingKey.USER_ID, response.data?.id);
      sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data?.fullName);
      sharedPreferenceManager.writeData(CachingKey.USER_PHONE, response.data?.phoneNumber);
      sharedPreferenceManager.writeData(CachingKey.PROFILE_IMAGE, response.data?.imageUrl);

      emit(state.copyWith(status: loginStatus.success,user: response.data));
    } else {
      emit(state.copyWith(status: loginStatus.failure,
      failureMessage: response.messageAr));
    }
  }

}
LoginBloc loginBloc = new LoginBloc();