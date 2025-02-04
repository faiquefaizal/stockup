import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stockup/db_funtions.dart/notification_funtion.dart';
import 'package:stockup/models/notification/notification_model.dart';

final FlutterLocalNotificationsPlugin localNotification =
    FlutterLocalNotificationsPlugin();

Future<void> notificationIntialize() async {
  const androidsettings = AndroidInitializationSettings("@mipmap/ic_launcher");
  InitializationSettings defaultSettings =
      const InitializationSettings(android: androidsettings);

  await localNotification.initialize(defaultSettings);
  await requestNotificationPermission();
}

Future<void> requestNotificationPermission() async {
  final androidpermission =
      localNotification.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  if (androidpermission != null) {
    await androidpermission.requestNotificationsPermission();
  }
}

Future<void> showNotifcation(
    {required String title, required String body}) async {
  var time = DateTime.now();
  var notificationmodel =
      NotificationModel(time: time, body: body, title: title);
  await addNotification(notificationmodel);
  const AndroidNotificationDetails stocknotificationDetails =
      AndroidNotificationDetails("stockcheck", "stockalert",
          importance: Importance.high, priority: Priority.high);

  NotificationDetails notificationDetails =
      const NotificationDetails(android: stocknotificationDetails);
  await localNotification.show(0, title, body, notificationDetails);
}
