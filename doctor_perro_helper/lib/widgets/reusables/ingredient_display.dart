import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/mixins/ingredients_mixin.dart';
import 'package:flutter/material.dart';

/// A widget that shows the [Ingredient] with colors
class IngredientDisplay extends StatelessWidget with IngredientsMixin {
  const IngredientDisplay({super.key, required this.ingredient});

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      ingredient.title,
      style: ingredientTextColor(theme, ingredient),
    );
  }
}
