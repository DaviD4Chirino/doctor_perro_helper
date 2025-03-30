import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/providers/streams/menu_order_stream.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/utils/extensions/order_list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodaysEarnings extends ConsumerWidget {
  TodaysEarnings({super.key});

  final DateTime now = DateTime.now();
  DateTime get todayFirstHour => DateTime(now.year, now.month, now.day);
  DateTime get todayLastHour => DateTime(now.year, now.month, now.day, 11, 59);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    AsyncValue<List<MenuOrder>> menuOrdersStream =
        ref.watch(menuOrdersStreamProvider);

    List<MenuOrder> allOrders = menuOrdersStream.maybeWhen(
      data: (data) {
        return data
            .where((order) =>
                order.status == OrderStatus.completed &&
                order.timeMade.isAfter(todayFirstHour))
            .toList();
      },
      orElse: () {
        return [MenuOrder(plates: [], packs: [])];
      },
    );

    return Container(
      padding: EdgeInsets.all(Sizes().xxl),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes().roundedSmall),
        // color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                allOrders.price().removePaddingZero(),
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.green,
                ),
              ),
              const Text(
                "\$",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              )
            ],
          ),
          Text(
            "Ganancias de hoy",
            style: TextStyle(
              fontSize: 12.0,
              color: theme.colorScheme.onSurface.withAlpha(170),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
