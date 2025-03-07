import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/providers/menu_order_provider.dart';
import 'package:doctor_perro_helper/widgets/orders/drafted_order.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable_plate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class NewOrder extends ConsumerStatefulWidget {
  NewOrder({super.key, this.onOrderModified});
  Function(MenuOrder order)? onOrderModified;

  @override
  ConsumerState<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends ConsumerState<NewOrder> {
  MenuOrder _order = MenuOrder(plates: [], packs: []);

  set order(MenuOrder newOrder) {
    _order = newOrder;
    if (widget.onOrderModified != null) widget.onOrderModified!(_order);
  }

  MenuOrder get order => _order;

  List<Plate> selectedPlates = [];
  List<PlatePack> selectedPacks = [];

  set draftedOrder(MenuOrder order) =>
      ref.read(menuOrderNotifierProvider.notifier).setDraftedOrder(order);

  MenuOrderData get menuOrder => ref.watch(menuOrderNotifierProvider);

  void onPlateSwipe(Plate plate, bool positive, double count) {
    if (plate.quantity.amount <= 0.0) {
      selectedPlates.removeWhere(
          (Plate existingPlate) => existingPlate.code == plate.code);

      draftedOrder = MenuOrder(packs: selectedPacks, plates: selectedPlates);
      return;
    }
    selectedPlates
        .removeWhere((Plate existingPlate) => existingPlate.code == plate.code);
    selectedPlates.add(plate);
    draftedOrder = MenuOrder(packs: selectedPacks, plates: selectedPlates);
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void onPackSwipe(PlatePack pack, bool positive, double count) {
    if (pack.quantity.amount <= 0.0) {
      selectedPacks.removeWhere(
          (PlatePack existingPack) => existingPack.code == pack.code);
      draftedOrder = MenuOrder(packs: selectedPacks, plates: selectedPlates);
      // printPlatesPackDebug(packs: order.packs);
      return;
    }
    selectedPacks.removeWhere(
        (PlatePack existingPack) => existingPack.code == pack.code);
    selectedPacks.add(pack);
    draftedOrder = MenuOrder(packs: selectedPacks, plates: selectedPlates);

    // printPlatesPackDebug(packs: order.packs);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle columnTitleStyle = TextStyle(
      fontSize: theme.textTheme.bodyLarge?.fontSize,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        draftedOrderSection(columnTitleStyle, theme),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              // InputOrderDirection(),
              // SizedBox(height: Sizes().xxxl),
              packSection(columnTitleStyle),
              plateSection(columnTitleStyle),
              extrasSection(columnTitleStyle),
            ],
          ),
        ),
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
    Widget draftedSection() {
      if (menuOrder.draftedOrder != null) {
        MenuOrder order = menuOrder.draftedOrder as MenuOrder;
        if (order.length > 0) {
          return DraftedOrder(order: order);
        } else {
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
            child: ListTile(
              // enabled: false,
              title: Text(
                  "Desliza hacia la derecha o izquierda en los platos para agregarlos"),
              subtitle: Text("No has seleccionado ningún plato"),
              dense: true,
            ),
          );
        }
      } else {
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
          child: ListTile(
            // enabled: false,
            title: Text(
                "Desliza hacia la derecha o izquierda en los platos para agregarlos"),
            subtitle: Text("No has seleccionado ningún plato"),
            dense: true,
          ),
        );
      }
    }

    return Section(
      title: Text(
        "Orden Seleccionada:",
        style: columnTitleStyle,
      ),
      child: draftedSection(),
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
