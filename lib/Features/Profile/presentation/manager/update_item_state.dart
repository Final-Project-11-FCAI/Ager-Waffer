import 'package:equatable/equatable.dart';

import '../../data/models/update_item_model.dart';

enum updateItemStatus { initial, loading, success, failure }

class UpdateItemState extends Equatable {
  Data itemData;
  updateItemStatus status;
  String failureMessage;

  UpdateItemState({
    required this.itemData,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [itemData, status, failureMessage];

  UpdateItemState copyWith({
    Data? itemData,
    updateItemStatus? status,
    String? failureMessage,
  }) {
    return UpdateItemState(
      itemData: itemData ?? this.itemData,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}