import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';

extension IngredientListExtensions on List<Ingredient> {
  List<Ingredient> replaceWhere(
    Ingredient oldIngredient,
    Ingredient newIngredient,
  ) {
    final int index =
        indexWhere((Ingredient ing) => ing.name == oldIngredient.name);

    if (index != -1) {
      this[index] = newIngredient;
      return this;
    }
    return this;
  }
}

extension SideDishListExtension on List<SideDish> {
  List<SideDish> replaceWhere(
    SideDish oldSideDish,
    SideDish newSideDish,
  ) {
    final int index =
        indexWhere((SideDish ing) => ing.name == oldSideDish.name);

    if (index != -1) {
      this[index] = newSideDish;
      return this;
    }
    return this;
  }
}
