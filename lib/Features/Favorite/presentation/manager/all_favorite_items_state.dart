import 'package:ager_waffer/Features/Favorite/data/models/all_favorite_items_model.dart';
import 'package:equatable/equatable.dart';

enum allFavoriteItemsStatus { initial, loading, success, failure }

class AllFavoriteItemsState extends Equatable {
  final List<FavoriteData> favoriteItems;
  final allFavoriteItemsStatus status;
  final String failureMessage;

  const AllFavoriteItemsState({
    required this.favoriteItems,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [favoriteItems, status, failureMessage];

  AllFavoriteItemsState copyWith({
    List<FavoriteData>? favoriteItems,
    allFavoriteItemsStatus? status,
    String? failureMessage,
  }) {
    return AllFavoriteItemsState(
      favoriteItems: favoriteItems ?? this.favoriteItems,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}