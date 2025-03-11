import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/widgets/expansible_pack.dart';
import 'package:doctor_perro_helper/widgets/expansible_plate.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditOrderStep extends ConsumerStatefulWidget {
  const EditOrderStep({super.key});

  @override
  ConsumerState<EditOrderStep> createState() => _EditOrderStepState();
}

class _EditOrderStepState extends ConsumerState<EditOrderStep> {
  MenuOrder get draftedOrder =>
      ref.watch(menuOrderNotifierProvider).draftedOrder as MenuOrder;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Section(
      title: Container(
        color: theme.colorScheme.surfaceContainer,
        child: ListTile(
          title: Text(
            "Editar orden",
          ),
          subtitle: Text(
            "Desliza los ingredientes para añadir o eliminar",


          ),
          dense: true,
        ),
      ),
      child: Expanded(
        child: ListView(
          children: [
            ...draftedOrder.packSpread.map((PlatePack pack) => ExpansiblePack(
                  pack: pack,
                  onSwiped: (dir, modifiedPack) {
                    MenuOrder newOrder = draftedOrder;
                    newOrder.replacePack(pack, modifiedPack);
                    ref
                        .read(menuOrderNotifierProvider.notifier)
                        .setDraftedOrder(newOrder);
                  },
                )),
            ...draftedOrder.platesSpread.map(
              (Plate plate) => ExpansiblePlate(
                plate: plate,
                onSwiped: (dir, modifiedPlate) {
                  MenuOrder newOrder = draftedOrder;
                  newOrder.replacePlate(plate, modifiedPlate);
                  ref
                      .read(menuOrderNotifierProvider.notifier)
                      .setDraftedOrder(newOrder);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
