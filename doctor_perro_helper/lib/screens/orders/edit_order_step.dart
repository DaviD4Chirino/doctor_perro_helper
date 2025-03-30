import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/utils/extensions/plate/plate_list_extensions.dart';
import 'package:doctor_perro_helper/utils/extensions/plate_pack_extensions/plate_pack_list_extensions.dart';
import 'package:doctor_perro_helper/widgets/expansible_pack.dart';
import 'package:doctor_perro_helper/widgets/expansible_plate.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditOrderStep extends ConsumerStatefulWidget {
  const EditOrderStep({super.key, required this.onStepCompleted});

  // final MenuOrder? draftedOrder;
  final Function(MenuOrder modifiedOrder) onStepCompleted;

  @override
  ConsumerState<EditOrderStep> createState() => _EditOrderStepState();
}

class _EditOrderStepState extends ConsumerState<EditOrderStep> {
  DraftedOrderNotifier get draftedOrderNotifier =>
      ref.read(draftedOrderNotifierProvider.notifier);

  // MenuOrder? get draftedOrder => ref.watch(draftedOrderNotifierProvider);

  MenuOrder get draftedOrder => ref.watch(draftedOrderNotifierProvider);

  late List<Plate> plates;
  late List<PlatePack> packs;
  // late MenuOrder draftedOrder;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    plates = draftedOrder.platesSpread;
    packs = draftedOrder.packSpread;
  }

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
            ...packs.map((PlatePack pack) => ExpansiblePack(
                  pack: pack,
                  onSwiped: (dir, modifiedPack) {
                    draftedOrderNotifier.setOrder(
                      draftedOrder.copyWith(
                        plates: plates,
                        packs: packs.replaceWhere(pack, modifiedPack),
                      ),
                    );
                  },
                )),
            ...plates.map(
              (Plate plate) => ExpansiblePlate(
                key: Key(plate.id),
                plate: plate,
                onSwiped: (dir, modifiedPlate) {
                  draftedOrderNotifier.setOrder(
                    draftedOrder.copyWith(
                      plates: plates.replaceWhere(plate, modifiedPlate),
                      packs: packs,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
