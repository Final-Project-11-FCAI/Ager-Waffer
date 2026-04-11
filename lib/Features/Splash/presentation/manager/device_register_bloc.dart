import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Splash/data/repositories/device_register_repository.dart';
import 'package:ager_waffer/Features/Splash/presentation/manager/device_register_state.dart';
import 'package:bloc/bloc.dart';

class DeviceRegisterBloc extends Bloc<AppEvent, DeviceRegisterState> {

  DeviceRegisterBloc()
      : super(const DeviceRegisterState(
    isRegistered: null,
    status: deviceRegisterStatus.initial,
  )) {
    on<DeviceRegisterEvent>(_onDeviceRegister);
  }

  Future<void> _onDeviceRegister(
      DeviceRegisterEvent event,
      Emitter<DeviceRegisterState> emit,
      ) async {

    emit(state.copyWith(status: deviceRegisterStatus.loading));

    var response = await deviceRegisterRepository.registerDevice(
      fcmToken: event.fcmToken,
      devicePlatform: event.devicePlatform,
    );

    if (response.isSuccess == true) {
      emit(state.copyWith(
        status: deviceRegisterStatus.success,
        isRegistered: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: deviceRegisterStatus.failure,
        failureMessage: response.messageAr ?? '',
      ));
    }
  }
}

DeviceRegisterBloc deviceRegisterBloc = DeviceRegisterBloc();