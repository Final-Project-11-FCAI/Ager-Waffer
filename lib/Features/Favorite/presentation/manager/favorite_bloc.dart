import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Favorite/data/repositories/favorite_repository.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/favorite_state.dart';
import 'package:bloc/bloc.dart';

class FavoriteBloc extends Bloc<AppEvent, FavoriteState> {

  FavoriteBloc() : super(FavoriteState()) {
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event,
      Emitter<FavoriteState> emit,
      ) async {

    emit(state.copyWith(
      status: favoriteStatus.loading,
      isFavorite: !state.isFavorite,
    ));

    try {
      var response = await favoriteRepository.toggleFavorite(
        itemId: event.itemId,
      );

      if (response.isSuccess == true) {
        emit(state.copyWith(
          status: favoriteStatus.success,
          favoriteData: response,
          isFavorite: response.data ?? false,
        ));
      } else {
        emit(state.copyWith(
          status: favoriteStatus.failure,
          failureMessage: response.messageAr ?? '',
          isFavorite: !state.isFavorite,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: favoriteStatus.failure,
        failureMessage: e.toString(),
        isFavorite: !state.isFavorite,
      ));
    }
  }
}

FavoriteBloc favoriteBloc = FavoriteBloc();