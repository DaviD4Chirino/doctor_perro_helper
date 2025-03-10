import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/widgets/dolar_and_bolivar_price_text.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
          style: TextStyle(
            color: textColor(theme),
          ),
        ),
        trailing: DolarAndBolivarPriceText(
          price: ingredient.price,
          // dolarPriceTextStyle: theme.textTheme.labelLarge,
        ),
      ),
    );
  }

  Color textColor(ThemeData theme) {
    if (ingredient.isTheMaximum) {
      return Colors.green;
    }
    if (ingredient.isTheMinimum) {
      return theme.colorScheme.error;
    }
    return theme.colorScheme.onSurface;
  }
}
