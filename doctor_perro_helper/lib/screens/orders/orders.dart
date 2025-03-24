import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/mixins/time_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/models/routes.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/Section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Orders extends ConsumerWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MenuOrderData menuOrderProvider = ref.watch(menuOrderNotifierProvider);
    /*   MenuOrderNotifier menuOrderNotifier =
        ref.read(menuOrderNotifierProvider.notifier); */

    List<MenuOrder> pendingOrders =
        menuOrderProvider.ordersWhere(OrderStatus.pending);

    List<MenuOrder> servedOrders =
        menuOrderProvider.ordersWhere(OrderStatus.completed);
    List<MenuOrder> cancelledOrders =
        menuOrderProvider.ordersWhere(OrderStatus.cancelled);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Nueva orden",
        onPressed: () => Navigator.pushNamed(context, Paths.newOrder),
        child: const Icon(
          Icons.add_circle,
          size: 32.0,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes().large),
        child: ListView(
          children: [
            SizedBox(
              height: Sizes().xxxl,
            ),
            DisplayOrders(
              orders: pendingOrders,
            ),
            DisplayOrders(
              title: "Ordenes Servidas",
              orders: servedOrders,
            ),
            DisplayOrders(
              title: "Ordenes Canceladas",
              orders: cancelledOrders,
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayOrders extends StatelessWidget {
  const DisplayOrders({
    super.key,
    required this.orders,
    this.title = "Ordenes Pendientes",
  });
  final String title;

  final List<MenuOrder> orders;

  @override
  Widget build(BuildContext context) {
    /*   MenuOrderNotifier menuOrderNotifier =
        ref.read(menuOrderNotifierProvider.notifier); */
    final ThemeData theme = Theme.of(context);

    /* List<MenuOrder> pendingOrders =
        menuOrderProvider.ordersWhere(OrderStatus.pending);

    List<MenuOrder> servedOrders =
        menuOrderProvider.ordersWhere(OrderStatus.completed); */

    return Section(
      title: Text(
        title,
        style: TextStyle(
          fontSize: theme.textTheme.titleLarge?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: orders.isNotEmpty
          ? Column(
              children: orders
                  .map(
                    (MenuOrder order) => ExpansibleOrder(
                      order: order,
                    ),
                  )
                  .toList(),
            )
          : Center(
              child: Text("No hay ${title.toLowerCase()}"),
            ),
    );
  }
}

// ignore: must_be_immutable
class ExpansibleOrder extends ConsumerWidget with TimeMixin {
  ExpansibleOrder({
    super.key,
    required this.order,
  });

  /// Determines if this order can be edited or modified

  MenuOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    MenuOrderNotifier menuOrderNotifier =
        ref.read(menuOrderNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        ListTile(
          leading: DolarAndBolivarPriceText(price: order.price),
          title: Text(
            getRelativeTime(order.status == OrderStatus.pending
                ? order.timeMade
                : order.timeFinished),
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
            ],
          ),
        ),
        if (order.status == OrderStatus.pending)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    menuOrderNotifier.serveOrder(order);
                  },
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
                    onTap: () {
                      menuOrderNotifier.cancelOrder(order);
                    },
                    child: Text("Cancelar orden"),
                  ),
                ],
              )
            ],
          ),
      ],
    );
  }
}
