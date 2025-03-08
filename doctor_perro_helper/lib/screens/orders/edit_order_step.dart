import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/widgets/expansible_plate.dart';
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
    return ListView(
      children: [
        ...draftedOrder.platesSpread.map(
          (Plate plate) => ExpansiblePlate(plate: plate),
        ),
      ],
    );
  }
}
