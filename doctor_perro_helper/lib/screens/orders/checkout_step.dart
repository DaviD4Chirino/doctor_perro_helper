import 'package:data_table_2/data_table_2.dart';
import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/mixins/plate_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/differences_in_plate.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutStep extends ConsumerStatefulWidget {
  const CheckoutStep({super.key});

  @override
  ConsumerState<CheckoutStep> createState() => _CheckoutStepState();
}

class _CheckoutStepState extends ConsumerState<CheckoutStep> with PlateMixin {
  MenuOrderData get menuOrderData => ref.watch(menuOrderNotifierProvider);

  late MenuOrder draftedOrder;

  // late List<Plate> mergedPlates2 = mergePlates(draftedOrder.plates);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (menuOrderData.draftedOrder == null) {
      throw Exception("menuOrderData.draftedOrder is null");
    }

    draftedOrder = menuOrderData.draftedOrder!;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Section(
      title: Container(
        color: theme.colorScheme.surfaceContainer,
        child: ListTile(
          title: Text("Confirma el pedido antes de continuar"),
        ),
      ),
      child: Expanded(
        child: Container(),
        /* child: DataTable2(
          dataTextStyle: theme.textTheme.titleSmall,
          headingTextStyle: theme.textTheme.titleMedium,
          headingRowHeight: 100,
          // lmRatio: 0.1,
          dataRowHeight: 150,
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
            ...mergedPlates2.map(
              (Plate plate) {
                // Get the differences plate

                return DataRow(
                  cells: [
                    DataCell(Text(plate.title)),
                    DataCell(
                      DifferencesInPlate(
                        plate: plate,
                      ),
                    ),
                  ],
                ); /*

                String difIngListTitles = plate.modifiedIngredients
                    .map(
                      (e) => e.title,
                    )
                    .join("\n");

                if (plate.quantity.amount > 1) {
                  return DataRow(
                    cells: [
                      DataCell(Text(plate.title)),
                      DataCell(
                        Text(plate.price.removePaddingZero()),
                      ),
                    ],
                  );
                }

                return DataRow(
                  cells: [
                    DataCell(Text("${plate.title}\n$difIngListTitles")),
                    DataCell(
                      Text(plate.price.removePaddingZero()),
                    ),
                  ],
                ); */
              },
            ),
            /* ...mergedPlates["merged_plates"]!.map(
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
            ),
           */
          ],
        ), */
      ),
    );
  }
}
