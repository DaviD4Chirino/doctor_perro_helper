import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/widgets/reusables/ingredient_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class ExpansiblePlate extends StatelessWidget {
  const ExpansiblePlate({super.key, required this.plate});

  final Plate plate;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ExpansionTile(
      title: Text(plate.title),
      childrenPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      leading: Text(
        plate.code,
        style: TextStyle(
          fontSize: theme.textTheme.titleMedium?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        ...plate.ingredients.map((Ingredient ingredient) {
          return ListTile(
            title: IngredientListTile(ingredient: ingredient),
          );
        }),
      ],
    );
  }
}
