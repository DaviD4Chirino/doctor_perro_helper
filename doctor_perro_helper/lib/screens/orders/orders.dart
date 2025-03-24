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
class ExpansibleOrder extends StatefulWidget {
  ExpansibleOrder({
    super.key,
    required this.order,
    this.editable = true,
  });

  /// Determines if this order can be edited or modified
  final bool editable;

  MenuOrder order;

  @override
  State<ExpansibleOrder> createState() => _ExpansibleOrderState();
}

class _ExpansibleOrderState extends State<ExpansibleOrder> with TimeMixin {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        ListTile(
          leading: DolarAndBolivarPriceText(price: widget.order.price),
          title: Text(
            getRelativeTime(widget.order.timeMade),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.order.codeList),
              Text(
                widget.order.direction,
                style: TextStyle(
                  fontSize: theme.textTheme.labelSmall?.fontSize,
                  color: theme.colorScheme.onSurface.withAlpha(200),
                ),
              ),
            ],
          ),
        ),
        if (widget.editable)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Servir"),
                ),
              ),
              PopupMenuButton(
                enableFeedback: true,
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    child: Text("Editar orden"),
                  ),
                  const PopupMenuItem(
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
