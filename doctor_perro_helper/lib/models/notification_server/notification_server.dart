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

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    NotificationDetails? details,
  }) async {
    return notificationPlugin.show(
      id,
      title,
      body,
      details,
    );
  }

  Future<void> showOrderNotification({
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
          "order",
          "Pedidos",
          channelDescription: "Alertas de los pedidos pendientes",
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
