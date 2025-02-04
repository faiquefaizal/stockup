import 'package:flutter/material.dart';
import 'package:stockup/db_funtions.dart/notification_funtion.dart';

class NotificationsHistory extends StatefulWidget {
  const NotificationsHistory({super.key});

  @override
  State<NotificationsHistory> createState() => _NotificationsHistoryState();
}

class _NotificationsHistoryState extends State<NotificationsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notifications History"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  await deleteNotification();
                },
                icon: const Icon(Icons.clear_all))
          ],
        ),
        body: ValueListenableBuilder(
            valueListenable: notificationNotifier,
            builder: (context, notifications, child) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var notification = notifications[index];
                    var diffents = timeDiffrence(notification.time);

                    return ListTile(
                      title: Text(notification.title),
                      subtitle: Text(notification.body),
                      trailing: Text(diffents),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: notifications.length);
            }));
  }
}
