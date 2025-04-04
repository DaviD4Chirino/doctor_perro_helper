import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/models/mixins/plate_mixin.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/providers/drafted_order_provider.dart';
import 'package:doctor_perro_helper/widgets/orders/drafted_order.dart';
import 'package:doctor_perro_helper/widgets/orders/input_order_direction.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable_pack.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable_plate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class NewOrderStep extends ConsumerStatefulWidget {
  NewOrderStep({
    super.key,
    this.onOrderModified,
    this.onStepCompleted,
  });

  Function(MenuOrder order)? onOrderModified;
  void Function(
    MenuOrder modifiedOrder,
  )? onStepCompleted;

  @override
  ConsumerState<NewOrderStep> createState() => _NewOrderState();
}

class _NewOrderState extends ConsumerState<NewOrderStep> with PlateMixin {
  DraftedOrderNotifier get draftedOrderNotifier =>
      ref.read(draftedOrderNotifierProvider.notifier);

  MenuOrder get draftedOrderProvider => ref.watch(draftedOrderNotifierProvider);

  List<Plate> selectedPlates = [];
  List<PlatePack> selectedPacks = [];

  late MenuOrder draftedOrder = MenuOrder(packs: [], plates: []);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /* set draftedOrder(MenuOrder order) {
    _draftedOrder = order;

    if (widget.onOrderModified != null) {
      widget.onOrderModified!(_draftedOrder);
    }

    if (widget.onStepCompleted != null &&
        order.direction.isNotEmpty &&
        order.length > 0) {
      widget.onStepCompleted!(_draftedOrder);
    }

    menuOrderNotifier.setDraftedOrder(_draftedOrder);
  } */

  void onPlateSwipe(Plate plate, bool positive, double count) {
    setState(() {
      if (plate.quantity.amount <= 0.0) {
        selectedPlates
            .removeWhere((Plate existingPlate) => existingPlate.id == plate.id);

        draftedOrder = draftedOrder.copyWith(plates: selectedPlates);

        if (widget.onOrderModified != null) {
          widget.onOrderModified!(draftedOrder);
        }
        return;
      }
      selectedPlates
          .removeWhere((Plate existingPlate) => existingPlate.id == plate.id);
      selectedPlates.add(plate);
      draftedOrder = draftedOrder.copyWith(plates: selectedPlates);

      draftedOrderNotifier.setOrder(draftedOrder);

      if (widget.onOrderModified != null) {
        widget.onOrderModified!(draftedOrder);
      }
    });
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void onPackSwipe(PlatePack pack, bool positive, double count) {
    setState(
      () {
        if (pack.quantity.amount <= 0.0) {
          selectedPacks.removeWhere(
              (PlatePack existingPack) => existingPack.id == pack.id);
          draftedOrder = draftedOrder.copyWith(packs: selectedPacks);

          if (widget.onOrderModified != null) {
            widget.onOrderModified!(draftedOrder);
          }
          draftedOrderNotifier.setOrder(draftedOrder);
          // printPlatesPackDebug(packs: order.packs);
          return;
        }
        selectedPacks.removeWhere(
            (PlatePack existingPack) => existingPack.id == pack.id);
        selectedPacks.add(pack);
        draftedOrder = draftedOrder.copyWith(packs: selectedPacks);

        if (widget.onOrderModified != null) {
          widget.onOrderModified!(draftedOrder);
        }
        draftedOrderNotifier.setOrder(draftedOrder);
      },
    );
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
              InputOrderDirection(
                onSubmitted: (text) {
                  draftedOrder = draftedOrder.copyWith(direction: text);
                  if (widget.onStepCompleted != null) {
                    widget.onStepCompleted!(draftedOrder);
                  }

                  draftedOrderNotifier.setOrder(draftedOrder);
                  /* draftedOrder = MenuOrder(packs: selectedPacks, plates: selectedPlates); */
                },
              ),
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
      if (draftedOrderProvider.length >= 1) {
        return DraftedOrder(order: draftedOrderProvider);
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
          child: const ListTile(
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
    // List<PlatePack> list =

    return Section(
      title: Text(
        "Combos",
        style: columnTitleStyle,
      ),
      child: Column(
        children: [
          ...PlateList.packs.map(
            (PlatePack pack) {
              PlatePack updatedPack = draftedOrderProvider.packs.firstWhere(
                (draftedPack) => draftedPack.code == pack.code,
                orElse: () => pack,
              );

              return SwipeablePack(
                key: Key(updatedPack.code),
                pack: updatedPack,
                onPackSwiped: onPackSwipe,
              );
            },
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
            (Plate plate) {
              return SwipeablePlate(
                key: Key(plate.id),
                plate: plate,
                onPlateSwiped: onPlateSwipe,
              );
            },
          )
        ],
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
