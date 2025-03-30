import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/extensions/ingredient_list_extensions.dart';
import 'package:doctor_perro_helper/utils/extensions/plate/plate_list_extensions.dart';
import 'package:doctor_perro_helper/widgets/expansible_plate.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable_ingredient.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class ExpansiblePack extends StatefulWidget {
  const ExpansiblePack({
    super.key,
    required this.pack,
    required this.onSwiped,
  });

  final PlatePack pack;

  final Function(
    SwipeDirection dir,
    PlatePack modifiedPack,
  ) onSwiped;

  @override
  State<ExpansiblePack> createState() => _ExpansiblePackState();
}

class _ExpansiblePackState extends State<ExpansiblePack> {
  late List<Plate> plates = [];

  @override
  void initState() {
    super.initState();
    plates = widget.pack.platesSpread;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      leading: Text(
        widget.pack.code,
        style: TextStyle(
          fontSize: theme.textTheme.titleMedium?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      title: Text(widget.pack.title),
      children: [
        ...plates.map(
          (Plate plate) {
            return ExpansiblePlate(
              plate: plate,
              onSwiped: (dir, modifiedPlate) {
                PlatePack newPack = widget.pack.copyWith(
                  plates: plates.replaceWhere(plate, modifiedPlate),
                );
                widget.onSwiped(dir, newPack);
              },
            );
          },
        ),
        if (widget.pack.extras != null) const Text("Extras"),
        if (widget.pack.extras != null)
          ...widget.pack.extras!.map(
            (SideDish extra) {
              return SwipeableIngredient(
                ingredient: extra,
                onSwiped: (dir, modifiedExtra) {
                  PlatePack newPack = widget.pack.copyWith(
                    extras: widget.pack.extras!.replaceWhere(
                      extra,
                      modifiedExtra.toSideDish(),
                    ),
                  );

                  widget.onSwiped(dir, newPack);
                },
              );
            },
          )
      ],
    );
  }
}
