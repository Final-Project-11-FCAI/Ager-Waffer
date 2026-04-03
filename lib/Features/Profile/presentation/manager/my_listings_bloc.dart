import 'dart:async';
import 'dart:io';

import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Profile/data/repositories/my_listings_repository.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/my_listings_state.dart';
import 'package:bloc/bloc.dart';

class MyListingsBloc extends Bloc<AppEvent , MyListingsState> {

  MyListingsBloc() :super(MyListingsState(myListings: [], status: myListingsStatus.initial)){
    on<GetMyListingsEvent>(_onGetMyListings);

  }

  Future<void> _onGetMyListings(
      GetMyListingsEvent event,
      Emitter<MyListingsState> emit,
      ) async {
    emit(state.copyWith(
      status: myListingsStatus.loading,
      failureMessage: '',
      failureType: null,
    ));

    try {
      final response = await myListingsRepository.getMyListings();

      if (response.isSuccess != true) {
        emit(state.copyWith(
          status: myListingsStatus.failure,
          failureMessage: response.messageAr ?? "حدث خطأ من السيرفر",
          failureType: FailureType.server,
        ));
        return;
      }

      final items = response.data?.data ?? [];

      if (items.isEmpty) {
        emit(state.copyWith(
          status: myListingsStatus.success,
          myListings: [],
        ));
        return;
      }

      emit(state.copyWith(
        status: myListingsStatus.success,
        myListings: items,
      ));

    } on SocketException {
      emit(state.copyWith(
        status: myListingsStatus.failure,
        failureMessage: "لا يوجد اتصال بالإنترنت",
        failureType: FailureType.network,
      ));

    } on TimeoutException {
      emit(state.copyWith(
        status: myListingsStatus.failure,
        failureMessage: "انتهت مهلة الاتصال، حاول مرة أخرى",
        failureType: FailureType.network,
      ));

    } on FormatException {
      emit(state.copyWith(
        status: myListingsStatus.failure,
        failureMessage: "خطأ في قراءة البيانات",
        failureType: FailureType.server,
      ));

    } catch (e) {
      emit(state.copyWith(
        status: myListingsStatus.failure,
        failureMessage: "حدث خطأ غير متوقع",
        failureType: FailureType.unknown,
      ));
    }
  }}
