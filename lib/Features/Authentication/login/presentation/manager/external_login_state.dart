import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:equatable/equatable.dart';

enum externalLoginStatus { initial, loading, success, failure }

class ExternalLoginState extends Equatable {
  final Data? user;
  final externalLoginStatus status;
  final String failureMessage;

  const ExternalLoginState({
    this.user,
    this.status = externalLoginStatus.initial,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [user, status, failureMessage];

  ExternalLoginState copyWith({
    Data? user,
    externalLoginStatus? status,
    String? failureMessage,
  }) {
    return ExternalLoginState(
      user: user ?? this.user,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}