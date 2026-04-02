import 'package:ager_waffer/Features/Profile/data/models/my_listings_model.dart';
import 'package:equatable/equatable.dart';

enum myListingsStatus{initial,loading,success,failure}

class MyListingsState extends Equatable{
  List<MyListingsData> myListings;
  myListingsStatus status;
  String failureMessage ;
  MyListingsState({required this.myListings,required this.status, this.failureMessage = ''});

  @override
  List<Object?> get props => [myListings,status,failureMessage];

  MyListingsState copyWith({
    List<MyListingsData>? myListings,
    myListingsStatus? status,
    String? failureMessage,
  }) {
    return MyListingsState(
      myListings: myListings ?? this.myListings,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }}