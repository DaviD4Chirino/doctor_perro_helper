import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable_plate.dart';
import 'package:flutter/foundation.dart';
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

  void onPlateSwipe(Plate plate, bool positive, double count) {
    if (plate.quantity.amount <= 0.0) {
      selectedPlates.removeWhere(
          (Plate existingPlate) => existingPlate.code == plate.code);
      printPlatesPackDebug(plates: selectedPlates);
      return;
    }
    selectedPlates
        .removeWhere((Plate existingPlate) => existingPlate.code == plate.code);
    selectedPlates.add(plate);
    printPlatesPackDebug(plates: selectedPlates);
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void onPackSwipe(PlatePack pack, bool positive, double count) {
    if (pack.quantity.amount <= 0.0) {
      selectedPacks.removeWhere(
          (PlatePack existingPack) => existingPack.code == pack.code);
      printPlatesPackDebug(packs: selectedPacks);
      return;
    }
    selectedPacks.removeWhere(
        (PlatePack existingPack) => existingPack.code == pack.code);
    selectedPacks.add(pack);
    printPlatesPackDebug(packs: selectedPacks);
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
                      onPlateSwiped: onPlateSwipe,
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
                      onPlateSwiped: onPlateSwipe,
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
              titleAlignment: ListTileTitleAlignment.top,
              trailing: DolarAndBolivarPriceText(
                price: 15.0,
              ),
              title: Text("4R4 - E1"),
              subtitle: Column(
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
              ),
            ),
          ],
        ));
  }
}

class ReviewPlate extends StatelessWidget {
  const ReviewPlate({
    super.key,
    required this.addedIngredients,
    required this.removedIngredients,
  });

  final List<Ingredient> addedIngredients;
  final List<Ingredient> removedIngredients;

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}

void printPlatesPackDebug({List<Plate>? plates, List<PlatePack>? packs}) {
  if (plates != null) {
    if (kDebugMode) {
      for (Plate plate in plates) {
        print(
            "Plate: \n code: ${plate.code}\n amount: ${plate.quantity.amount}");
      }
    }
  }
  if (packs != null) {
    if (kDebugMode) {
      for (PlatePack pack in packs) {
        print("Pack: \n code: ${pack.code}\n amount: ${pack.quantity.amount}");
      }
    }
  }
}
