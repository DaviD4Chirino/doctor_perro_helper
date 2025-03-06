import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
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
  MenuOrder order = MenuOrder(plates: [], packs: []);

  List<Plate> selectedPlates = [];
  List<PlatePack> selectedPacks = [];

  void onPlateSwipe(Plate plate, bool positive, double count) {
    if (plate.quantity.amount <= 0.0) {
      selectedPlates.removeWhere(
          (Plate existingPlate) => existingPlate.code == plate.code);
      setState(() {
        order = MenuOrder(packs: selectedPacks, plates: selectedPlates);
      });

      printPlatesPackDebug(plates: order.plates);
      return;
    }
    selectedPlates
        .removeWhere((Plate existingPlate) => existingPlate.code == plate.code);
    selectedPlates.add(plate);
    setState(() {
      order = MenuOrder(packs: selectedPacks, plates: selectedPlates);
    });
    printPlatesPackDebug(plates: order.plates);
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void onPackSwipe(PlatePack pack, bool positive, double count) {
    if (pack.quantity.amount <= 0.0) {
      selectedPacks.removeWhere(
          (PlatePack existingPack) => existingPack.code == pack.code);
      setState(() {
        order = MenuOrder(packs: selectedPacks, plates: selectedPlates);
      });
      // printPlatesPackDebug(packs: order.packs);
      return;
    }
    selectedPacks.removeWhere(
        (PlatePack existingPack) => existingPack.code == pack.code);
    selectedPacks.add(pack);
    setState(() {
      order = MenuOrder(packs: selectedPacks, plates: selectedPlates);
    });
    // printPlatesPackDebug(packs: order.packs);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle columnTitleStyle = TextStyle(
      fontSize: theme.textTheme.bodyLarge?.fontSize,
      fontWeight: FontWeight.bold,
    );
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        draftedOrderSection(columnTitleStyle, theme),
        // InputOrderDirection(),
        // SizedBox(height: Sizes().xxxl),
        packSection(columnTitleStyle),
        plateSection(columnTitleStyle),
        extrasSection(columnTitleStyle),
      ],
    ); /* Scaffold(
      appBar: AppBar(
        title: const Text("Nueva orden"),
      ),

      // hide this
      // bottomNavigationBar: order.length > 0 ? bottomNavigationBar() : null,
      persistentFooterButtons: [bottomNavigationBar(theme)],
      body:
    ) */
  }

  Section draftedOrderSection(TextStyle columnTitleStyle, ThemeData theme) {
    return Section(
      title: Text(
        "Orden Seleccionada:",
        style: columnTitleStyle,
      ),
      child: order.length > 0
          ? DraftedOrder(order: order)
          : Container(
              color: theme.colorScheme.surfaceContainer,
              child: ListTile(
                // enabled: false,
                title: Text(
                    "Desliza hacia la derecha o izquierda en los platos para agregarlos"),
                subtitle: Text("No has seleccionado ningún plato"),
                dense: true,
              ),
            ),
    );
  }

  Section packSection(TextStyle columnTitleStyle) {
    return Section(
      title: Text(
        "Combos",
        style: columnTitleStyle,
      ),
      child: Column(
        children: [
          ...PlateList.packs.map(
            (PlatePack pack) => SwipeablePack(
              key: Key(pack.code),
              pack: pack,
              onPackSwiped: onPackSwipe,
            ),
          )
        ],
      ),
    );
  }

  Section extrasSection(TextStyle columnTitleStyle) {
    return Section(
      title: Text(
        "Extras",
        style: columnTitleStyle,
      ),
      child: Column(
        children: [
          ...PlateList.extras.map(
            (Plate extra) => SwipeablePlate(
              key: Key(extra.code),
              plate: extra,
              onPlateSwiped: onPlateSwipe,
            ),
          )
        ],
      ),
    );
  }

  Section plateSection(TextStyle columnTitleStyle) {
    return Section(
      title: Text(
        "Platos",
        style: columnTitleStyle,
      ),
      child: Column(
        children: [
          ...PlateList.plates.map(
            (Plate plate) => SwipeablePlate(
              key: Key(plate.code),
              plate: plate,
              onPlateSwiped: onPlateSwipe,
            ),
          )
        ],
      ),
    );
  }
}

class InputOrderDirection extends StatelessWidget {
  const InputOrderDirection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        label: Text("Dirección"),
      ),
    );
  }
}

class DraftedOrder extends ConsumerWidget {
  const DraftedOrder({super.key, required this.order});

  final MenuOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
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
