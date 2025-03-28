import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServer {
  final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;

    const initSettingsAndroid =
        AndroidInitializationSettings("@mipmap/launcher_icon");

    const initSettings = InitializationSettings(android: initSettingsAndroid);

    await notificationPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return NotificationDetails(
        android: AndroidNotificationDetails(
      "daily-notifications",
      "Daily Notifications",
      channelDescription: "Test description",
      importance: Importance.max,
      priority: Priority.high,
    ));
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          "home-notifications",
          "Home Notifications",
          channelDescription: "Test description",
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
