import 'package:ager_waffer/Features/Notification/data/models/notifications_model.dart';
import 'package:equatable/equatable.dart';

enum notificationsStatus { initial, loading, success, failure }

class NotificationsState extends Equatable {
  final List<NotificationsData> notifications;
  final notificationsStatus status;
  final String failureMessage;

  const NotificationsState({
    required this.notifications,
    required this.status,
    this.failureMessage = '',
  });

  @override
  List<Object?> get props => [notifications, status, failureMessage];

  NotificationsState copyWith({
    List<NotificationsData>? notifications,
    notificationsStatus? status,
    String? failureMessage,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}