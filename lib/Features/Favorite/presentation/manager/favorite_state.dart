import 'package:equatable/equatable.dart';
import '../../data/models/favorite_model.dart';

enum favoriteStatus { initial, loading, success, failure }

class FavoriteState extends Equatable {
  final Map<int, bool> favorites;
  final favoriteStatus status;
  final String failureMessage;
  final FavoriteModel? favoriteData;

  const FavoriteState({
    this.favorites = const {},
    this.status = favoriteStatus.initial,
    this.failureMessage = '',
    this.favoriteData,
  });

  @override
  List<Object?> get props => [favorites, status, failureMessage, favoriteData];

  FavoriteState copyWith({
    Map<int, bool>? favorites,
    favoriteStatus? status,
    String? failureMessage,
    FavoriteModel? favoriteData,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
      favoriteData: favoriteData ?? this.favoriteData,
    );
  }
}