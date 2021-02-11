import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification{
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  InitializationSettings _initializationSettings;
  LocalNotification._(){
    _initializePlugin();
  }
  void _initializePlugin(){
    _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
    final android= AndroidInitializationSettings('appstore');
    _initializationSettings=InitializationSettings(android:android);
  }
  Future<bool>onSelectNotification(Function(String payload) onSelect)async{
  return await _flutterLocalNotificationsPlugin.initialize(_initializationSettings,onSelectNotification:
  onSelect,
  );
  }
  removeNotification(int id )async{
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
