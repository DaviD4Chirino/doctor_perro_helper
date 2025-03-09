import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/widgets/reusables/ingredient_list_tile.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable.dart';
import 'package:flutter/material.dart';

class ExpansiblePlate extends StatelessWidget {
  const ExpansiblePlate({super.key, required this.plate});

  final Plate plate;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ExpansionTile(
      // minTileHeight: 0,
      // tilePadding: EdgeInsets.all(0),
      // childrenPadding: EdgeInsets.all(-15),
      title: Text(plate.title),
      // childrenPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      leading: Text(
        plate.code,
        style: TextStyle(
          fontSize: theme.textTheme.titleMedium?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        ...plate.ingredients.map((Ingredient ingredient) {
          return Swipeable(
            swipeTileColor: theme.colorScheme.surface,
            key: Key(ingredient.name),
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.bottom,
              horizontalTitleGap: 0,
              dense: true,
              title: IngredientListTile(ingredient: ingredient),
              subtitle: Text("Desliza para añadir o eliminar"),
            ),
            onSwiped: (swipeDirection) {},
          );
        }),
      ],
    );
  }
}
