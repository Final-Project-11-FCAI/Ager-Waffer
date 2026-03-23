import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/Helper/app_state.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/shared_preference_manger.dart';
import 'package:ager_waffer/Base/validator.dart';
import 'package:ager_waffer/Features/Authentication/login/data/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc extends Bloc<AppEvent,AppState> with Validator {

  AuthenticationBloc() :super(Start()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    // on<VerifyOtpEvent>(_onVerifyOtp);
    // on<ResendOtpEvent>(_onResendOtp);
    // on<RefreshTokenEvent>(_onRefreshToken);
    // on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event,
      Emitter<AppState> emit) async {
    emit(LoginLoading());
    var response = await authenticationRepository.login(
        email: event.email, password: event.password,
    );

    if (response.isSuccess! ) {
      sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data?.token);
      sharedPreferenceManager.writeData(CachingKey.USER_ID, response.data?.id);
      sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data?.fullName);
      sharedPreferenceManager.writeData(CachingKey.USER_PHONE, response.data?.phoneNumber);
      sharedPreferenceManager.writeData(CachingKey.PROFILE_IMAGE, response.data?.imageUrl);

      emit(LoginDoneState(model: response));
    } else {
      emit(LoginErrorLoadingState(message:  response.messageAr));
    }
  }


  Future<void> _onRegister(RegisterEvent event,
      Emitter<AppState> emit) async {
    emit(RegisterLoading());
    var response = await authenticationRepository.register(
        registerEntity: event.registerEntity
    );

    print("Response: ${response.toJson()}");
    print("isSuccess: ${response.isSuccess}");
    print("message: ${response.messageAr}");

    if (response.isSuccess! ) {
      // sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data?.token);
      // sharedPreferenceManager.writeData(CachingKey.USER_ID, response.data?.id);
      // sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data?.fullName);
      // sharedPreferenceManager.writeData(CachingKey.USER_PHONE, response.data?.phoneNumber);
      // sharedPreferenceManager.writeData(CachingKey.PROFILE_IMAGE, response.data?.imageUrl);
      emit(RegisterDoneState(model: response));
    } else {
      emit(RegisterErrorLoadingState(message:  response.messageAr));
    }
  }



}

AuthenticationBloc authenticationBloc = AuthenticationBloc();