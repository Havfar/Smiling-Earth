part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsRetrived extends NotificationsState {
  final List<NotificationDto> notifications;

  NotificationsRetrived(this.notifications);
}

class NotificationCountRetrived extends NotificationsState {
  final int notificaitonCount;

  NotificationCountRetrived(this.notificaitonCount);
}

class NotificationsRetrivedError extends NotificationsState {
  final String error;

  NotificationsRetrivedError(this.error);
}
