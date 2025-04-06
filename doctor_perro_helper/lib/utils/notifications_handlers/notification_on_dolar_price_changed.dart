import 'package:doctor_perro_helper/models/notification_server/notification_server.dart';
import 'package:doctor_perro_helper/models/providers/subscriptions/dolar_price_subscription.dart';
import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';

void notificationOnDolarPriceChanged() {
  dolarPriceSubscription.onData(
    (data) async {
      if (data.history.isEmpty) {
        return;
      }

      double latestValue = data.latestDolarPrice?.value ?? 0.0;

      double? savedLatestValue =
          UseSharedPreferences.preferences.getDouble("latest-dolar-price");

      if (savedLatestValue != null && savedLatestValue == latestValue) {
        return;
      }

      UseSharedPreferences.preferences
          .setDouble("latest-dolar-price", latestValue);

      NotificationServer.showDolarChangedNotification(
        id: 1,
        title: "El precio del dolar ha sido actualizado",
        body: "${latestValue.removePaddingZero()}bs",
      );
    },
  );
}
