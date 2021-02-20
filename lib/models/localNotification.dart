import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotification {
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  InitializationSettings _initializationSettings;

  LocalNotification._() {
    _initializePlugin();
  }

  void _initializePlugin() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('appstore');
    _initializationSettings = InitializationSettings(android: android);
  }

  onSelectNotification(Function(String payload) onSelect) async {
     await _flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
      onSelectNotification: (payload)async{
        print('payLoad $payload');
       onSelect(payload);},
    );
  }

  addScheduleNotification(
      String id, String title, String description, DateTime datetime) {
    tz.initializeTimeZones();
    tz.Location nigeria = tz.getLocation('Africa/Lagos');
    tz.TZDateTime date = tz.TZDateTime.from(datetime, nigeria);
    final forAndroid = AndroidNotificationDetails(id, title, description,
        icon: 'appstore',
        priority: Priority.max,
        importance: Importance.max,
        color: Colors.blueAccent,
        channelShowBadge: true,
        largeIcon: DrawableResourceAndroidBitmap('appstore'),
        fullScreenIntent: true,
        enableLights: true,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('slack'),

    );
    final notificationDetails = NotificationDetails(android: forAndroid);
    _flutterLocalNotificationsPlugin.zonedSchedule(int.parse(id),
        'It\'s time to be On Time', title, date, notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        payload: id);
  }

  removeNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}

LocalNotification localNotification = LocalNotification._();
