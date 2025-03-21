import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:flutter/material.dart';

/// Represents the differences as a single plate
class DifferencesInPlate extends StatelessWidget {
  const DifferencesInPlate({
    super.key,
    required this.plate,
  });

  final Plate plate;

  Plate get differences {
    List<Ingredient> ingredients = plate.ingredients;
    List<SideDish>? extras = plate.extras;

    Plate basePlate = plate.base;
    basePlate.ingredients = ingredients;
    basePlate.extras = extras;

    return basePlate;
  }

  String get difIngListTitles =>
      differences.modifiedIngredients.map((e) => e.title).join("\n");

  @override
  Widget build(BuildContext context) {
    return Text(difIngListTitles);
  }
}
