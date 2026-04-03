import 'package:ager_waffer/Features/Profile/data/models/delete_item_model.dart';
import 'package:equatable/equatable.dart';


enum deleteItemStatus { initial, loading, success, failure }

class DeleteItemState extends Equatable {
  DeleteItemModel? response;
  deleteItemStatus status;
  String failureMessage;

  DeleteItemState({
    this.response,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [response, status, failureMessage];

  DeleteItemState copyWith({
    DeleteItemModel? response,
    deleteItemStatus? status,
    String? failureMessage,
  }) {
    return DeleteItemState(
      response: response ?? this.response,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}