import 'package:equatable/equatable.dart';

import '../../data/models/add_item_model.dart';

enum addItemStatus{initial,loading,success,failure}

class AddItemState extends Equatable{
  Data itemData;
  addItemStatus status;
  String failureMessage ;
  AddItemState({required this.itemData,required this.status, this.failureMessage = ''});

  @override
  List<Object?> get props => [itemData,status,failureMessage];

  AddItemState copyWith({
    Data? itemData,
    addItemStatus? status,
    String? failureMessage,
  }) {
    return AddItemState(
      itemData: itemData ?? this.itemData,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }}