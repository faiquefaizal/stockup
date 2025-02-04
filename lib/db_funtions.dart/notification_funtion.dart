import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stockup/models/notification/notification_model.dart';

ValueNotifier<List<NotificationModel>> notificationNotifier = ValueNotifier([]);
const String NOTIFICATION_BOX = "notification";

Future<void> addNotification(NotificationModel notification) async {
  var box = Hive.box<NotificationModel>(NOTIFICATION_BOX);
  await box.add(notification);
  getnotification();
}

void getnotification() {
  notificationNotifier.value.clear();
  var box = Hive.box<NotificationModel>(NOTIFICATION_BOX);

  notificationNotifier.value.addAll(box.values);
  notificationNotifier.notifyListeners();
}

Future<void> deleteNotification() async {
  var box = Hive.box<NotificationModel>(NOTIFICATION_BOX);
  await box.clear();
  getnotification();
}

String timeDiffrence(DateTime time) {
  DateTime currentTime = DateTime.now();
  var difference = currentTime.difference(time);
  if (difference.inMinutes < 1) {
    return "Just now";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} minutes ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  } else {
    return "${difference.inDays} days ago";
  }
}
