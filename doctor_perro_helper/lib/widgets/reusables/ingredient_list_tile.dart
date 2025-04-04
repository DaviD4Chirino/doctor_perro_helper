import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:flutter/material.dart';

class IngredientListTile extends StatelessWidget {
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
          style: ingredientTextColor(theme),
        ),
        trailing: DolarAndBolivarPriceText(
          price: ingredient.price,
          // dolarPriceTextStyle: theme.textTheme.labelLarge,
        ),
      ),
    );
  }

  TextStyle? ingredientTextColor(ThemeData theme) {
    if (ingredient.isTheMaximum
        //  || ((ingredient.quantity?.amount ?? 1.0) > 1)
        ) {
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
