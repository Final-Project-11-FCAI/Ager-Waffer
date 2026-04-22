import 'package:equatable/equatable.dart';
import '../../data/models/favorite_model.dart';

enum favoriteStatus { initial, loading, success, failure }

class FavoriteState extends Equatable {
  FavoriteModel? favoriteData;
  favoriteStatus status;
  String failureMessage;
  bool isFavorite;

  FavoriteState({
    this.favoriteData,
    this.status = favoriteStatus.initial,
    this.failureMessage = '',
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [favoriteData, status, failureMessage, isFavorite];

  FavoriteState copyWith({
    FavoriteModel? favoriteData,
    favoriteStatus? status,
    String? failureMessage,
    bool? isFavorite,
  }) {
    return FavoriteState(
      favoriteData: favoriteData ?? this.favoriteData,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}