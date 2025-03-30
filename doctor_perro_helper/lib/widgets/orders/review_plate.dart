import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:flutter/material.dart';

class ReviewPlate extends StatelessWidget {
  const ReviewPlate({
    super.key,
    required this.addedIngredients,
    required this.removedIngredients,
  });

  final List<Ingredient> addedIngredients;
  final List<Ingredient> removedIngredients;

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
