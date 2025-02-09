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
              if (notifications.isEmpty) {
                return const Center(
                  child: Text(
                    "No Notifications Yet!",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                );
              }
              return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    var notification = notifications[index];
                    var diffents = timeDiffrence(notification.time);

                    return Card(
                      color: Colors.grey,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(
                          notification.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          notification.body,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                        trailing: Text(
                          diffents,
                          style: const TextStyle(color: Colors.black45),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: notifications.length);
            }));
  }
}
