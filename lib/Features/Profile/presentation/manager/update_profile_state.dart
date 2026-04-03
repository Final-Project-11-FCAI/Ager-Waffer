import 'package:equatable/equatable.dart';

import '../../data/models/update_profile_model.dart';

enum updateProfileStatus { initial, loading, success, failure }

class UpdateProfileState extends Equatable {
  Data profileData;
  updateProfileStatus status;
  String failureMessage;

  UpdateProfileState({
    required this.profileData,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [profileData, status, failureMessage];

  UpdateProfileState copyWith({
    Data? profileData,
    updateProfileStatus? status,
    String? failureMessage,
  }) {
    return UpdateProfileState(
      profileData: profileData ?? this.profileData,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}