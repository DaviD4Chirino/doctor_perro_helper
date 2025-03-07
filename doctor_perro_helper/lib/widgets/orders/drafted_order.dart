import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DraftedOrder extends ConsumerWidget {
  const DraftedOrder({super.key, required this.order});

  final MenuOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline,
            width: 2.0,
          ),
        ),
      ),
      padding: EdgeInsets.only(bottom: Sizes().xl),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        trailing: DolarAndBolivarPriceText(
          price: order.price,
        ),
        title: Text(order.codeList),

        /* subtitle: Column(
          children: [
            ListTile(
              title: Text("1R1:"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Sizes().xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // First the added things
                        Text(
                          "+ 150g de Papas",
                        ),
                        // Second the considerations
                        Text(
                          "* Poca Mostaza",
                        ),
                        // Third the removed
                        Text(
                          "- Queso de año",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Sizes().medium),
                  Text(
                    "Calle Jabonería Casa 11",
                    style: TextStyle(
                      fontSize: theme.textTheme.labelMedium?.fontSize,
                      color: theme.colorScheme.onSurface.withAlpha(150),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ), */
      ),
    );
  }
}
