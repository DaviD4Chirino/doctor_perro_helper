import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/mixins/time_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/models/routes.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/Section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
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
            PendingOrders(),
          ],
        ),
      ),
    );
  }
}

class PendingOrders extends ConsumerWidget {
  const PendingOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MenuOrderData menuOrderProvider = ref.watch(menuOrderNotifierProvider);
    final ThemeData theme = Theme.of(context);

    return Section(
      title: Text(
        "Ordenes Pendientes",
        style: TextStyle(
          fontSize: theme.textTheme.titleLarge?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: menuOrderProvider.history.isNotEmpty
          ? Column(
              children: menuOrderProvider.history
                  .map(
                    (MenuOrder e) => ExpansibleOrder(
                      order: e,
                    ),
                  )
                  .toList(),
            )
          : const Center(
              child: Text("No pending orders"),
            ),
    );
  }
}

// ignore: must_be_immutable
class ExpansibleOrder extends StatefulWidget {
  ExpansibleOrder({super.key, required this.order});

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
                  color: theme.colorScheme.onSurface.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Servido"),
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
