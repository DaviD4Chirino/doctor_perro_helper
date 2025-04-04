import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/mixins/ingredients_mixin.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:flutter/material.dart';

class IngredientListTile extends StatelessWidget with IngredientsMixin {
  const IngredientListTile({
    super.key,
    required this.ingredient,
    this.dense = false,
  });

  final Ingredient ingredient;

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes().roundedSmall)),
      ),
      child: ListTile(
        dense: dense,
        title: Text(
          ingredient.title,
          style: ingredientTextColor(theme, ingredient),
        ),
        trailing: DolarAndBolivarPriceText(
          price: ingredient.price,
          // dolarPriceTextStyle: theme.textTheme.labelLarge,
        ),
      ),
    );
  }
}
