import 'package:data_table_2/data_table_2.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutStep extends ConsumerWidget {
  const CheckoutStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          rows: const [
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
