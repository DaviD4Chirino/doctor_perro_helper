import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationServer {
  static final notificationPlugin = FlutterLocalNotificationsPlugin();

  static bool isInitialized = false;

  static Future<void> initialize() async {
    if (isInitialized) return;

    const initSettingsAndroid =
        AndroidInitializationSettings("@drawable/ic_stat_doctor_perro_head");

    const initSettings = InitializationSettings(android: initSettingsAndroid);

    await notificationPlugin.initialize(initSettings);
    isInitialized = true;
  }

  static Future<void> showNotification({
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

  static Future<void> showOrderNotification({
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

  static Future<void> showDolarChangedNotification({
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
          "dolar-price-change",
          "Cambios en el precio del dolar",
          channelDescription: "Cambios en el precio del dolar",
          importance: Importance.low,
          priority: Priority.low,
        ),
      ),
    );
  }
}
