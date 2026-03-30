import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:equatable/equatable.dart';

enum allItemsStatus{initial,loading,success,failure}

class AllItemsState extends Equatable{
  List<ProductData> product;
  allItemsStatus status;
  String failureMessage ;
  AllItemsState({required this.product,required this.status, this.failureMessage = ''});

  @override
  List<Object?> get props => [product,status,failureMessage];

  AllItemsState copyWith({
    List<ProductData>? product,
    allItemsStatus? status,
    String? failureMessage,
  }) {
    return AllItemsState(
      product: product ?? this.product,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }}