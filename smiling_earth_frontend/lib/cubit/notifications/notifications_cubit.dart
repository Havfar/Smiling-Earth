import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/notifications/notification_client.dart';
import 'package:smiling_earth_frontend/models/notifications.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationClient _client = NotificationClient();
  NotificationsCubit() : super(NotificationsInitial());

  void getNotificaitons() {
    try {
      _client
          .getNotificaitons()
          .then((notifications) => emit(NotificationsRetrived(notifications)));
    } catch (e) {
      emit(NotificationsRetrivedError(e.toString()));
    }
  }

  void getNotificationCount() {
    try {
      _client
          .getNewNotificaitonsCount()
          .then((value) => emit(NotificationCountRetrived(value)));
    } catch (e) {
      emit(NotificationsRetrivedError(e.toString()));
    }
  }
}
