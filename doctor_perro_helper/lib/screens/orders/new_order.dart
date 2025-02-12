import 'dart:developer';

import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable_plate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  List<Plate> selectedPlates = [];
  List<PlatePack> selectedPacks = [];

  void onPlateSwipe(Plate plate, bool positive) {
    if (positive) selectedPlates.add(plate);
    if (!positive) {
      selectedPlates.removeWhere(
          (Plate existingPlate) => existingPlate.code == plate.code);
    }
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void onPackSwipe(PlatePack pack, bool positive, double count) {
    log(pack.quantity.amount.toString());
    selectedPacks.removeWhere(
        (PlatePack existingPack) => existingPack.code == pack.code);
    selectedPacks.add(pack);
    // log(pack.quantity.amount.toString());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva orden"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().large,
        ),
        child: ListView(
          children: [
            const DraftedOrder(),
            Section(
              title: Text(
                "Combos",
                style: TextStyle(
                  fontSize: themeContext.textTheme.titleLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Column(
                children: [
                  ...PlateList.packs.map(
                    (PlatePack pack) => SwipeablePack(
                      pack: pack,
                      onPackSwiped: onPackSwipe,
                    ),
                  )
                ],
              ),
            ),
            Section(
              title: Text(
                "Platos",
                style: TextStyle(
                  fontSize: themeContext.textTheme.titleLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Column(
                children: [
                  ...PlateList.plates.map(
                    (Plate plate) => SwipeablePlate(
                      plate: plate,
                      onPlateSwiped: (plate, direction, count) {},
                    ),
                  )
                ],
              ),
            ),
            Section(
              title: Text(
                "Extras",
                style: TextStyle(
                  fontSize: themeContext.textTheme.titleLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Column(
                children: [
                  ...PlateList.extras.map(
                    (Plate extras) => SwipeablePlate(
                      plate: extras,
                      onPlateSwiped: (plate, direction, count) {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DraftedOrder extends ConsumerStatefulWidget {
  const DraftedOrder({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DraftedOrderState();
}

class DraftedOrderState extends ConsumerState<DraftedOrder> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Section(
        title: Text(
          "Orden seleccionada",
          style: TextStyle(
            fontSize: theme.textTheme.titleLarge?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              leading: DolarAndBolivarPriceText(
                price: 15.0,
              ),
            )
          ],
        ));
  }
}
