import 'package:data_table_2/data_table_2.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutStep extends ConsumerWidget {
  const CheckoutStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MenuOrderData menuOrderData = ref.watch(menuOrderNotifierProvider);

    MenuOrder draftedOrder =
        menuOrderData.draftedOrder ?? MenuOrder(plates: [], packs: []);

    List<Plate> plates = draftedOrder.plates;

    final List<Plate> mergedPlates = mergePlates(plates);

    ThemeData theme = Theme.of(context);

    return Section(
      title: Container(
        color: theme.colorScheme.surfaceContainer,
        child: ListTile(
          title: Text("Confirma el pedido antes de continuar"),
        ),
      ),
      child: Expanded(
        child: DataTable2(
          dataTextStyle: theme.textTheme.titleSmall,
          headingTextStyle: theme.textTheme.titleMedium,
          columns: [
            DataColumn2(
              label: Text("Total\nTotal en bolivares"),
              size: ColumnSize.L,
              headingRowAlignment: MainAxisAlignment.spaceBetween,
            ),
            DataColumn2(
              label: DolarAndBolivarPriceText(price: draftedOrder.price),
              size: ColumnSize.S,
              numeric: true,
            ),
          ],
          rows: [
            ...mergedPlates.map(
              (Plate plate) {
                return DataRow(
                  cells: [
                    DataCell(Text(plate.title)),
                    DataCell(
                      Text("${plate.price.removePaddingZero()}\$"),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

List<Plate> mergePlates(List<Plate> plates) {
  List<Plate> mergedPlates = [];

  for (Plate plate in plates) {
    bool found = false;
    for (int i = 0; i < mergedPlates.length; i++) {
      Plate mergedPlate = mergedPlates[i];

      if (plate.ingredientsTitles == mergedPlate.ingredientsTitles) {
        mergedPlates[i].quantity.amount += 1;
        found = true;
        break;
      }
    }

    /* for (Plate mergedPlate in mergedPlates) {
      if (_arePlatesEqual(plate, mergedPlate)) {
        mergedPlate = mergedPlate
            .amount(mergedPlate.quantity.amount + plate.quantity.amount);
        found = true;
        break;
      }
    } */

    if (!found) {
      mergedPlates.add(plate);
    }
  }

  return mergedPlates;
}
