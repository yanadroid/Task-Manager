// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const CHANNEL_ID = "task_manager_id";
const CHANNEL_NAME = "task_manager_name";
const CHANNEL_DESCRIPTION = "Task Manager";


void scheduleNotification(String taskId, String title, String body, DateTime scheduledNotificationDateTime) async {
  tz.initializeTimeZones();
  final tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduledNotificationDateTime, tz.local);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(CHANNEL_ID, CHANNEL_NAME,
      channelDescription: CHANNEL_DESCRIPTION,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false);
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
      taskId.hashCode,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime);
}
