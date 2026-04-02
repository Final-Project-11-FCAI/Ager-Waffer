import 'package:ager_waffer/Features/Profile/data/models/my_listings_model.dart';
import 'package:equatable/equatable.dart';

enum myListingsStatus{initial,loading,success,failure}
enum FailureType {
  network,
  server,
  unauthorized,
  unknown,
}

class MyListingsState extends Equatable {
  final List<MyListingsData> myListings;
  final myListingsStatus status;
  final String failureMessage;
  final FailureType? failureType;

  const MyListingsState({
    required this.myListings,
    required this.status,
    this.failureMessage = '',
    this.failureType,
  });

  @override
  List<Object?> get props => [myListings, status, failureMessage, failureType];

  MyListingsState copyWith({
    List<MyListingsData>? myListings,
    myListingsStatus? status,
    String? failureMessage,
    FailureType? failureType,
  }) {
    return MyListingsState(
      myListings: myListings ?? this.myListings,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
      failureType: failureType ?? this.failureType,
    );
  }
}