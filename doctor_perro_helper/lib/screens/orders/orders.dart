import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/providers/streams/menu_order_stream.dart';
import 'package:doctor_perro_helper/models/providers/streams/user_data_provider_stream.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/models/routes.dart';
import 'package:doctor_perro_helper/utils/extensions/order_list_extensions.dart';
import 'package:doctor_perro_helper/widgets/orders/display_orders.dart';
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
