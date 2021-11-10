import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/notifications/notification_client.dart';
import 'package:smiling_earth_frontend/cubit/notifications/notifications_cubit.dart';
import 'package:smiling_earth_frontend/models/notifications.dart';
import 'package:smiling_earth_frontend/pages/challenges/challenge_detailed.dart';
import 'package:smiling_earth_frontend/pages/post_detailed.dart';
import 'package:smiling_earth_frontend/pages/user/follower_page.dart';
import 'package:smiling_earth_frontend/widgets/circle_avatar.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green),
        ),
        drawer: NavigationDrawerWidget(),
        body: ListView(
          children: [
            Text('notifcation'),
            BlocProvider(
              create: (context) => NotificationsCubit()..getNotificaitons(),
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsRetrived) {
                    if (state.notifications.isEmpty) {
                      return Text('No notifaction found');
                    }
                    return Column(
                        children: state.notifications
                            .map((notification) => Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: _buildNotification(
                                    notification: notification,
                                  ),
                                ))
                            .toList());
                  }
                  return Text('loading');
                },
              ),
            )
          ],
        ),
      );
}

class _buildNotification extends StatelessWidget {
  final NotificationDto notification;
  final NotificationClient client = NotificationClient();

  _buildNotification({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _notReadColor = Colors.blue.shade100;
    var _readColor = Colors.white;
    switch (notification.notificationType) {
      case 0:
        return ListTile(
          leading: UserAvatar(avatar: notification.fromUser!.avatar),
          title: Text(
              "${notification.fromUser!.getName()} commented on your post"),
          subtitle: Text(notification.timestamp.toString()),
          tileColor: notification.userHasSeen ? _readColor : _notReadColor,
          onTap: () {
            client.notificationRead(notification.id!);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailedPostPage(postId: notification.post!),
            ));
          },
        );
      case 1:
        return ListTile(
          leading: UserAvatar(avatar: notification.fromUser!.avatar),
          title: Text("${notification.fromUser!.getName()} liked your post"),
          subtitle: Text(notification.timestamp.toString()),
          tileColor: notification.userHasSeen ? _readColor : _notReadColor,
          onTap: () {
            client.notificationRead(notification.id!);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailedPostPage(postId: notification.post!),
            ));
          },
        );
      case 2:
        return ListTile(
          leading: CircleIcon(
            backgroundColor: Colors.lightBlueAccent,
            emoji: '🏆',
          ),
          title: Text(notification.message!),
          tileColor: notification.userHasSeen ? _readColor : _notReadColor,
          subtitle: Text(notification.timestamp.toString()),
          onTap: () {
            client.notificationRead(notification.id!);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailedChallengesPage(id: notification.challenge!),
            ));
          },
        );

      case 3:
        return ListTile(
          leading: UserAvatar(avatar: notification.fromUser!.avatar),
          title:
              Text("${notification.fromUser!.getName()} is now following you"),
          tileColor: notification.userHasSeen ? _readColor : _notReadColor,
          subtitle: Text(notification.timestamp.toString()),
          onTap: () {
            client.notificationRead(notification.id!);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FollowerPage(),
            ));
          },
        );
      default:
        return ListTile(
          leading: CircleIcon(
            backgroundColor: Colors.lightGreenAccent,
            emoji: '❗️',
          ),
          title: Text(notification.message!),
          tileColor: notification.userHasSeen ? _readColor : _notReadColor,
          subtitle: Text(notification.timestamp.toString()),
          onTap: () => {client.notificationRead(notification.id!)},
        );
    }
  }
}
