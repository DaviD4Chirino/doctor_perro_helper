import 'package:doctor_perro_helper/models/mixins/time_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/utils/database/orders_helper.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpansibleOrder extends ConsumerWidget with TimeMixin {
  ExpansibleOrder({
    super.key,
    required this.order,
    this.accountId = "",
  });

  MenuOrder order;

  /// The id of the currently logged account
  String accountId;

  DateTime get statusTime {
    switch (order.status) {
      case OrderStatus.cancelled:
        return order.timeCancelled;

      case OrderStatus.completed:
        return order.timeFinished;

      case OrderStatus.pending:
        return order.timeOrdered;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    DraftedOrderNotifier menuOrderNotifier =
        ref.read(draftedOrderNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        ListTile(
          leading: DolarAndBolivarPriceText(price: order.price),
          title: Text(
            getRelativeTime(statusTime),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.codeList),
              Text(
                order.direction,
                style: TextStyle(
                  fontSize: theme.textTheme.labelSmall?.fontSize,
                  color: theme.colorScheme.onSurface.withAlpha(200),
                ),
              ),
              Text(order.id),
            ],
          ),
        ),
        // if (order.status == OrderStatus.pending)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: order.madeBy == accountId &&
                        order.status == OrderStatus.pending
                    ? () {
                        menuOrderNotifier.serveOrder(order);
                      }
                    : null,
                child: const Text("Servir"),
              ),
            ),
            PopupMenuButton(
              enableFeedback: true,
              itemBuilder: (BuildContext context) => [
                /*  PopupMenuItem(
                    onTap: () {
                      menuOrderNotifier.editOrder(order);
                      Navigator.pushNamed(context, Paths.newOrder);
                    },
                    child: Text("Editar orden"),
                  ), */

                PopupMenuItem(
                  enabled: order.madeBy == accountId,
                  onTap: () {
                    order.status = OrderStatus.cancelled;
                    uploadOrder(order);
                  },
                  child: Text(
                    "Cancelar orden",
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
