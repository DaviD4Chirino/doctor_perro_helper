import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate.dart';
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
      children: [
        ...plate.ingredients.map(
          (Ingredient ingredient) {
            return SwipeableIngredient(
              ingredient: ingredient,
              onSwiped: (dir, modifiedIngredient) {
                Plate newPlate = plate;
                newPlate.replaceIngredient(ingredient, modifiedIngredient);
                onSwiped(dir, newPlate);
              },
            );
          },
        ),
      ],
    );
  }
}
