import 'package:data_table_2/data_table_2.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
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
    MenuOrder drafted_order =
        menuOrderData.draftedOrder ?? MenuOrder(plates: [], packs: []);

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
          columns: const [
            DataColumn2(
              label: Text('Column A'),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text('Column B'),
              size: ColumnSize.S,
              headingRowAlignment: MainAxisAlignment.end,
              numeric: true,
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(
                  DolarAndBolivarPriceText(
                    price: drafted_order.price,
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("TOTAL")),
                DataCell(Text("20\$")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
