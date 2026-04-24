import 'package:ager_waffer/Base/Helper/app_event.dart';
import 'package:ager_waffer/Features/Favorite/data/repositories/favorite_repository.dart';
import 'package:ager_waffer/Features/Favorite/presentation/manager/favorite_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class FavoriteBloc extends Bloc<AppEvent, FavoriteState> {
  FavoriteBloc() : super(const FavoriteState()) {
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<SyncFavoritesEvent>(_onSyncFavorites);
  }

  /// ✅ Sync from API
  void _onSyncFavorites(
      SyncFavoritesEvent event,
      Emitter<FavoriteState> emit,
      ) {
    if (mapEquals(state.favorites, event.favorites)) return;

    emit(state.copyWith(
      favorites: event.favorites,
    ));
  }

  /// ✅ Toggle
  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event,
      Emitter<FavoriteState> emit,
      ) async {
    final updated = Map<int, bool>.from(state.favorites);
    final currentValue = updated[event.itemId] ?? false;

    /// optimistic update
    updated[event.itemId] = !currentValue;

    emit(state.copyWith(
      favorites: updated,
      status: favoriteStatus.loading,
    ));

    try {
      final response =
      await favoriteRepository.toggleFavorite(itemId: event.itemId);

      if (response.isSuccess == true) {
        updated[event.itemId] = response.data ?? false;

        emit(state.copyWith(
          favorites: updated,
          status: favoriteStatus.success,
        ));
      } else {
        updated[event.itemId] = currentValue;

        emit(state.copyWith(
          favorites: updated,
          status: favoriteStatus.failure,
        ));
      }
    } catch (_) {
      updated[event.itemId] = currentValue;

      emit(state.copyWith(
        favorites: updated,
        status: favoriteStatus.failure,
      ));
    }
  }
}