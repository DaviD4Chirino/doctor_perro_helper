import 'package:data_table_2/data_table_2.dart';
import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/consumers/bolivar_price_text.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/mixins/ingredients_mixin.dart';
import 'package:doctor_perro_helper/models/mixins/pack_mixin.dart';
import 'package:doctor_perro_helper/models/mixins/plate_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/providers/drafted_order_provider.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/dolar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/display_pack_diferencies.dart';
import 'package:doctor_perro_helper/widgets/reusables/display_plate_diferencies.dart';
import 'package:doctor_perro_helper/widgets/reusables/ingredient_display.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class CheckoutStep extends ConsumerStatefulWidget {
  CheckoutStep({super.key, this.onStepCompleted});

  void Function(
    MenuOrder modifiedOrder,
  )? onStepCompleted;

  @override
  ConsumerState<CheckoutStep> createState() => _CheckoutStepState();
}

class _CheckoutStepState extends ConsumerState<CheckoutStep>
    with PlateMixin, PackMixin, IngredientsMixin {
  MenuOrder get draftedOrder => ref.watch(draftedOrderNotifierProvider);

  late List<Plate> plates = draftedOrder.platesSpread;
  late List<PlatePack> packs = draftedOrder.packSpread;

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
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Costo en dólares:"),
                DolarPriceText(price: draftedOrder.price),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Costo en Bolivares:"),
                BolivarPriceText(
                  price: draftedOrder.price,
                  textStyle: theme.textTheme.bodySmall,
                ),
              ],
            ),
            ...divider(theme),
            ...packs.map(
              (pack) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DisplayPackDiferencies(pack),
                    ...divider(theme),
                  ],
                );
              },
            ),
            ...plates.map(
              (plate) {
                return Column(
                  children: [
                    DisplayPlateDiferencies(plate),
                    ...divider(theme),
                  ],
                );
              },
            ),
          ],
        ),

        /* LayoutGrid(
          gridFit: GridFit.loose,
          columnSizes: [1.fr, 0.2.fr],
          rowSizes: [
            auto,
            auto,
            ...plates.map(
              (e) => auto,
            )
          ],
          // autoPlacement: AutoPlacement.rowSparse,
          children: [
            Text("Costo en dólares:"),
            DolarPriceText(price: draftedOrder.price),
            Text("Costo en Bolivares:"),
            BolivarPriceText(
              price: draftedOrder.price,
              textStyle: theme.textTheme.bodySmall,
            ),
            ...plates.map(
              (plate) {
                return Text(
                  plate.title,
                );
              },
            ),
          ],
        ), */

        /* DataTable2(
          lmRatio: 1.0,
          columns: [
            DataColumn2(
              label: Text("Costo en dólares:\nCosto en Bolivares:"),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: DolarAndBolivarPriceText(price: draftedOrder.price),
              numeric: true,
            )
          ],
          rows: [
            DataRow2(cells: [
              DataCell(Text("Dirección:")),
              DataCell(
                Text(draftedOrder.direction),
              ),
            ]),
            ...packs.map(
              (PlatePack pack) {
                return DataRow2(cells: [
                  DataCell(Text(pack.title)),
                  DataCell(
                    DolarPriceText(
                      price: pack.price,
                    ),
                  ),
                ]);
              },
            ),
            ...plates.map(
              (Plate plate) {
                return DataRow2(
                  cells: [
                    DataCell(
                      Column(
                        children: [
                          Text(plate.title),
                          Text(
                            plate.getDifferences(plate.base).ingredientsTitles,
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      DolarPriceText(
                        price: plate.price,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ), */
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

  List<Widget> divider(ThemeData theme) => [
        SizedBox(
          height: Sizes().xl,
        ),
        Container(
          color: theme.colorScheme.primary,
          height: Sizes().small,
        ),
        SizedBox(
          height: Sizes().xxl,
        ),
      ];
}
