import 'package:hive_flutter/hive_flutter.dart';
part 'notification_model.g.dart';

@HiveType(typeId: 5)
class NotificationModel {
  @HiveField(0)
  DateTime time;
  @HiveField(1)
  String title;
  @HiveField(2)
  String body;
  NotificationModel(
      {required this.time, required this.body, required this.title});
}
