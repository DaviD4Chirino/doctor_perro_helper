import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/screens/orders/orders.dart';
import 'package:doctor_perro_helper/widgets/reusables/Section.dart';
import 'package:doctor_perro_helper/widgets/reusables/expansible_order.dart';
import 'package:flutter/material.dart';

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
          fontSize: theme.textTheme.bodyLarge?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: orders.isNotEmpty
          ? Column(
              spacing: Sizes().medium,
              children: [
                ...orders.map(
                  (MenuOrder order) => ExpansibleOrder(
                    key: Key(order.id),
                    order: order,
                    accountId: accountId,
                  ),
                ),
                SizedBox(height: Sizes().large),
              ],
            )
          : Center(
              child: Text("No hay ${title.toLowerCase()}\n"),
            ),
    );
  }
}
