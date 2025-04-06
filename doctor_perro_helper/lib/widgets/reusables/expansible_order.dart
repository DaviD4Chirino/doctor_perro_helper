import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/mixins/time_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/order/menu_order_status.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/providers/drafted_order_provider.dart';
import 'package:doctor_perro_helper/utils/database/orders_helper.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/display_pack_diferencies.dart';
import 'package:doctor_perro_helper/widgets/reusables/display_plate_diferencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        ExpansionTile(
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
              // Text(order.id),
            ],
          ),
          children: [
            ...order.packs.map(
              (pack) {
                PlatePack diff = pack.getDifferences(pack.base);
                if (diff.plateTitleList != "" || diff.extrasTitles != "") {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes().large,
                    ),
                    child: DisplayPackDiferencies(pack),
                  );
                }
                // * We dont need to show this but if needed
                // return DisplayPackDiferencies(pack);
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes().large,
                  ),
                  child: DisplayPackDiferencies(pack),
                );
              },
            ),
            SizedBox(
              height: Sizes().medium,
            ),
            Container(
              color: theme.colorScheme.surfaceContainer,
              height: Sizes().small,
            ),
            SizedBox(
              height: Sizes().xl,
            ),
            ...order.plates.map(
              (plate) {
                Plate diff = plate.getDifferences(plate.base);
                if (diff.ingredientsTitles != "" || diff.extrasTitles != "") {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes().large,
                    ),
                    child: DisplayPlateDiferencies(plate),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes().large,
                  ),
                  child: DisplayPlateDiferencies(plate),
                );
              },
            ),
            SizedBox(
              height: Sizes().xl,
            ),
          ],
        ),
        if (order.status == OrderStatus.pending)
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
