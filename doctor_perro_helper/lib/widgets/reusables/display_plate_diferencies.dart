import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/widgets/dolar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/ingredient_display.dart';
import 'package:flutter/material.dart';

class DisplayPlateDiferencies extends StatelessWidget {
  const DisplayPlateDiferencies(
    this.plate, {
    super.key,
    this.displayPrice = true,
  });
  final Plate plate;
  final bool displayPrice;
  Plate get differencesInPlate => plate.getDifferences(plate.base);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plate.title),
                if (differencesInPlate.ingredientsTitles != "")
                  ...differencesInPlate.ingredients.map(
                    (ingredient) {
                      return Padding(
                        padding: EdgeInsets.only(left: Sizes().large),
                        child: IngredientDisplay(ingredient),
                      );
                    },
                  ),
                if (differencesInPlate.extrasTitles != "")
                  ...differencesInPlate.extras!.map(
                    (SideDish ingredient) {
                      return IngredientDisplay(ingredient);
                    },
                  ),
              ],
            ),
            if (displayPrice)
              DolarPriceText(
                price: plate.price,
                textStyle: theme.textTheme.bodyLarge,
              ),
          ],
        ),
      ],
    );
  }
}
