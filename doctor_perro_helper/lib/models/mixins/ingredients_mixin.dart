import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:flutter/material.dart';

mixin IngredientsMixin {
  TextStyle? ingredientTextColor(ThemeData theme, Ingredient ingredient) {
    if ( //ingredient.isTheMaximum
        ((ingredient.quantity?.amount ?? 1.0) > 1)) {
      return TextStyle(
        color: Colors.green,
      );
    }
    if (ingredient.isTheMinimum) {
      return TextStyle(
        color: Colors.red,
        decoration: TextDecoration.lineThrough,
        decorationColor: Colors.red,
      );
    }

    return null;
  }
}
