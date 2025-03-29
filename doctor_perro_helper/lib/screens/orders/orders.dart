import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/mixins/time_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/models/providers/streams/menu_order_stream.dart';
import 'package:doctor_perro_helper/models/providers/streams/user_data_provider_stream.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/models/routes.dart';
import 'package:doctor_perro_helper/utils/database/orders_helper.dart';
import 'package:doctor_perro_helper/utils/extensions/order_list_extensions.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/Section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({super.key});

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {
  /* late Timer timer = Timer.periodic(
    Duration(seconds: 5),
    (timer) {},
  ); */

  AsyncValue<UserData> get userDataStream => ref.watch(userDataProvider);

  AsyncValue<List<MenuOrder>> get menuOrdersStream =>
      ref.watch(menuOrdersStreamProvider);

  bool get loadingOrders => menuOrdersStream.maybeWhen(
        data: (data) => false,
        orElse: () => true,
      );

  List<MenuOrder> get allOrders => menuOrdersStream.maybeWhen(
        data: (data) {
          return data;
        },
        orElse: () {
          return [MenuOrder(plates: [], packs: [])];
        },
      );

  String get userId => userDataStream.maybeWhen(
        data: (data) => data.user?.uid ?? "",
        orElse: () => "",
      );
  List<MenuOrder> get pendingOrders =>
      allOrders.whereStatus(OrderStatus.pending)
        ..sort((a, b) => b.timeMade.isAfter(a.timeMade) ? 1 : 0);
  List<MenuOrder> get servedOrders =>
      allOrders.whereStatus(OrderStatus.completed)
        ..sort((a, b) => b.timeFinished.isAfter(a.timeFinished) ? 1 : 0);
  List<MenuOrder> get cancelledOrders =>
      allOrders.whereStatus(OrderStatus.cancelled)
        ..sort((a, b) => b.timeCancelled.isAfter(a.timeCancelled) ? 1 : 0);

  @override
  void initState() {
    super.initState();
    /*  timer =
        Timer.periodic(const Duration(seconds: 5), (timer) => setState(() {})); */
  }

  @override
  void dispose() {
    super.dispose();
    // timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // MenuOrderData menuOrderProvider = ref.watch(menuOrderNotifierProvider);
    /*   MenuOrderNotifier menuOrderNotifier =
        ref.read(menuOrderNotifierProvider.notifier); */

    return Scaffold(
      floatingActionButton:
          floatingActionButton(theme, context, userDataStream),
      body: loadingOrders
          ? LinearProgressIndicator()
          : Padding(
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

  FloatingActionButton? floatingActionButton(ThemeData theme,
      BuildContext context, AsyncValue<UserData> userDataStream) {
    return userDataStream.when(
      data: (data) {
        return FloatingActionButton(
          backgroundColor: userId == "" ? theme.disabledColor : null,
          tooltip: "Nueva orden",
          onPressed: userId != ""
              ? () => Navigator.pushNamed(context, Paths.newOrder)
              : null,
          child: const Icon(
            Icons.add_circle,
            size: 32.0,
          ),
        );
      },
      error: (error, stackTrace) {
        return FloatingActionButton(
          backgroundColor: theme.disabledColor,
          onPressed: null,
          tooltip: "Necesitas iniciar sesión",
          child: const Icon(
            Icons.close_rounded,
            size: 32.0,
          ),
        );
      },
      loading: () {
        return FloatingActionButton(
          onPressed: null,
          tooltip: "Loading...",
          child: CircularProgressIndicator(),
        );
      },
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
