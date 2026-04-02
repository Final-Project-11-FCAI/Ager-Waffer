import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Home/data/repositories/all_items_repository.dart';
import 'package:ager_waffer/Features/Home/presentation/manager/all_items_state.dart';
import 'package:ager_waffer/Features/Profile/data/repositories/my_listings_repository.dart';
import 'package:ager_waffer/Features/Profile/presentation/manager/my_listings_state.dart';
import 'package:bloc/bloc.dart';

class MyListingsBloc extends Bloc<AppEvent , MyListingsState> {

  MyListingsBloc() :super(MyListingsState(myListings: [], status: myListingsStatus.initial)){
    on<GetMyListingsEvent>(_onGetMyListings);

  }

  Future<void> _onGetMyListings(GetMyListingsEvent event,
      Emitter<MyListingsState> emit,) async {
    print("EVENT STARTED");

    emit(state.copyWith(status: myListingsStatus.loading));

    try {
      print("BEFORE API");
      var response = await myListingsRepository.getMyListings();
      print("AFTER API");

      print("isSuccess: ${response.isSuccess}");
      print("full response: $response");

      if (response.isSuccess == true) {
        emit(
          state.copyWith(
            status: myListingsStatus.success,
            myListings: response.data?.data ?? [],
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: myListingsStatus.failure,
            failureMessage: response.messageAr ?? "Error",
          ),
        );
      }
    } catch (e) {
      print("ERROR: $e");

      emit(
        state.copyWith(
          status: myListingsStatus.failure,
          failureMessage: e.toString(),
        ),
      );
    }
  }
}
MyListingsBloc myListingsBloc = new MyListingsBloc();