import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/mixins/time_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/models/providers/streams/menu_order_stream.dart';
import 'package:doctor_perro_helper/models/providers/streams/user_data_provider_stream.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/models/routes.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/Section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Orders extends ConsumerWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    AsyncValue<UserData> userDataStream = ref.watch(userDataProvider);
    final AsyncValue<List<MenuOrder>> menuOrdersStream =
        ref.watch(menuOrderStream);

    final MenuOrderData allOrders = menuOrdersStream.maybeWhen(
      data: (data) => MenuOrderData(history: data),
      orElse: () => MenuOrderData(history: []),
    );

    String userId = userDataStream.maybeWhen(
      data: (data) => data.user?.uid ?? "",
      orElse: () => "",
    );

    /* MenuOrderData menuOrderProvider = ref.watch(menuOrderNotifierProvider); */
    /*   MenuOrderNotifier menuOrderNotifier =
        ref.read(menuOrderNotifierProvider.notifier); */

    List<MenuOrder> pendingOrders = allOrders.ordersWhere(OrderStatus.pending);
    List<MenuOrder> servedOrders = allOrders.ordersWhere(OrderStatus.completed);
    List<MenuOrder> cancelledOrders =
        allOrders.ordersWhere(OrderStatus.cancelled);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: userId == "" ? theme.disabledColor : null,
        tooltip: "Nueva orden",
        onPressed: userId != ""
            ? () => Navigator.pushNamed(context, Paths.newOrder)
            : null,
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
              accountId: userId,
            ),
            DisplayOrders(
              title: "Ordenes Servidas",
              orders: servedOrders,
              accountId: userId,
            ),
            DisplayOrders(
              title: "Ordenes Canceladas",
              orders: cancelledOrders,
              accountId: userId,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DisplayOrders extends StatelessWidget {
  DisplayOrders({
    super.key,
    required this.orders,
    this.title = "Ordenes Pendientes",
    this.accountId = "",
  });
  final String title;

  final List<MenuOrder> orders;

  /// The id of the currently logged account
  String accountId;

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
              spacing: Sizes().medium,
              children: orders
                  .map(
                    (MenuOrder order) => ExpansibleOrder(
                      key: Key(order.id),
                      order: order,
                      accountId: accountId,
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
        return order.timeMade;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    MenuOrderNotifier menuOrderNotifier =
        ref.read(menuOrderNotifierProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: order.status != OrderStatus.cancelled
            ? theme.colorScheme.surfaceContainer
            : null,
        borderRadius: BorderRadius.circular(Sizes().roundedSmall),
      ),
      child: Column(
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
          if (order.status != OrderStatus.cancelled)
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
                        menuOrderNotifier.cancelOrder(order);
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
      ),
    );
  }
}
