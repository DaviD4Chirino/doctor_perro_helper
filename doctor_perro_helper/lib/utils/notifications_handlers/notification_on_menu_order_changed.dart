import 'package:doctor_perro_helper/models/notification_server/notification_server.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/providers/subscriptions/menu_order_subscription.dart';
import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:doctor_perro_helper/utils/extensions/order_list_extensions.dart';

void notificationOnMenuOrderChanged() {
  menuOrderSubscription.onData(
    (data) {
      if (data.isEmpty) {
        return;
      }
      List<MenuOrder> pendingOrders = data.whereStatus(OrderStatus.pending);

      if (pendingOrders.isEmpty) return;
      MenuOrder latestOrder = pendingOrders.first;

      String? latestMenuOrderId =
          UseSharedPreferences.preferences.getString("latest-menu-order-id");

      if (latestMenuOrderId != null && latestMenuOrderId == latestOrder.id) {
        return;
      }

      UseSharedPreferences.preferences
          .setString("latest-menu-order-id", latestOrder.id);

      NotificationServer.showOrderNotification(
        body: latestOrder.codeList,
        id: 0,
        title: "Hay Ordenes Pendientes",
      );
    },
  );
}
