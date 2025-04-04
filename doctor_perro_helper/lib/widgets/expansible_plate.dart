import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/utils/extensions/ingredient_list_extensions.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable_ingredient.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class ExpansiblePlate extends StatelessWidget {
  const ExpansiblePlate({
    super.key,
    required this.plate,
    required this.onSwiped,
  });

  final Plate plate;

  final Function(
    SwipeDirection dir,
    Plate modifiedPlate,
  ) onSwiped;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ExpansionTile(
      title: Text(plate.title),
      leading: Text(
        plate.code,
        style: TextStyle(
          fontSize: theme.textTheme.titleMedium?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      // subtitle: Text(plate.id),
      children: [
        ...ingredientsSection(),
        if (plate.extras != null) ...extrasSection(),
      ],
    );
  }

  Iterable<Widget> extrasSection() {
    if (plate.extras == null) return [Container()];
    return plate.extras!.map(
      (SideDish sideDish) {
        return SwipeableIngredient(
          ingredient: sideDish,
          onSwiped: (dir, modifiedIngredient) {
            Plate newExtra = plate.copyWith(
              extras: plate.extras!.replaceWhere(
                sideDish,
                modifiedIngredient.toSideDish(),
              ),
            );
            onSwiped(dir, newExtra);
          },
        );
      },
    );
  }

  Iterable<Widget> ingredientsSection() {
    return plate.ingredients.map(
      (Ingredient ingredient) {
        return SwipeableIngredient(
          key: Key(ingredient.name),
          ingredient: ingredient,
          onSwiped: (dir, modifiedIngredient) {
            Plate newPlate = plate.copyWith(
              ingredients: plate.ingredients
                  .replaceWhere(ingredient, modifiedIngredient),
            );
            onSwiped(dir, newPlate);
          },
        );
      },
    );
  }
}
