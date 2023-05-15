import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService()
      : flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin() {
    final initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // Handle notification selection on iOS
      },
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleRepeatingAlarm(
    int alarmId,
    String alarmTitle,
    TimeOfDay alarmTime,
    int dayOfWeek,
  ) async {
    tz.initializeTimeZones();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alarm_channel_id',
      'Alarm',
      channelDescription: "Your description",
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Get the current date and time
    final now = tz.TZDateTime.now(tz.local);

    // Get the next alarm date based on the specified day of the week and time
    final nextAlarmDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + (dayOfWeek - now.weekday),
      alarmTime.hour,
      alarmTime.minute,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      alarmId,
      alarmTitle,
      'Wake up!',
      nextAlarmDate,
      platformChannelSpecifics,
      // androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: 'Repeating alarm',
    );
  }
}
