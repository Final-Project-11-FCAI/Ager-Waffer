import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Features/Favorite/data/repositories/all_favorite_items_repository.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/all_favorite_items_state.dart';
import 'package:bloc/bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AllFavoriteItemsBloc extends Bloc<AppEvent, AllFavoriteItemsState> {

  AllFavoriteItemsBloc()
      : super(AllFavoriteItemsState(
    favoriteItems: [],
    status: allFavoriteItemsStatus.initial,
  )) {

    on<GetAllFavoriteItemsEvent>(_onGetFavoriteItems);
  }

  Future<void> _onGetFavoriteItems(
      GetAllFavoriteItemsEvent event,
      Emitter<AllFavoriteItemsState> emit,
      ) async {

    emit(state.copyWith(status: allFavoriteItemsStatus.loading));

    try {
      var response = await allFavoriteItemsRepository.getFavoriteItems();

      if (response.isSuccess == true) {
        print("favorite count: ${response.data?.data?.length}");

        emit(state.copyWith(
          status: allFavoriteItemsStatus.success,
          favoriteItems: response.data?.data ?? [],
        ));
      } else {
        emit(state.copyWith(
          status: allFavoriteItemsStatus.failure,
          failureMessage: response.messageAr ?? kSomethingWrong.tr(),
        ));
      }

    } catch (e) {
      print("ERROR: $e");

      emit(state.copyWith(
        status: allFavoriteItemsStatus.failure,
        failureMessage: kServerError.tr(),
      ));
    }
  }
}

AllFavoriteItemsBloc allFavoriteItemsBloc = AllFavoriteItemsBloc();