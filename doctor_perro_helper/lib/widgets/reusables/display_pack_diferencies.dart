import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:doctor_perro_helper/widgets/dolar_price_text.dart';
import 'package:doctor_perro_helper/widgets/reusables/display_plate_diferencies.dart';
import 'package:doctor_perro_helper/widgets/reusables/ingredient_display.dart';
import 'package:flutter/material.dart';

class DisplayPackDiferencies extends StatelessWidget {
  const DisplayPackDiferencies(this.pack, {super.key});
  final PlatePack pack;

  PlatePack get packDifferences => pack.getDifferences(pack.base);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pack.title),
            ...pack.plates.map(
              (plate) {
                final Plate differences = plate.getDifferences(plate.base);
                if (differences.extrasTitles != "" ||
                    differences.ingredientsTitles != "") {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: Sizes().xl,
                      bottom: Sizes().medium,
                    ),
                    child: DisplayPlateDiferencies(
                      plate,
                      displayPrice: false,
                    ),
                  );
                }
                return Container();
              },
            ),
            // its close to v1.0 so i dont care
            if (packDifferences.extras != null &&
                packDifferences.extras!.isNotEmpty &&
                packDifferences.extrasTitles != "")
              ...packDifferences.extras!.map(
                (SideDish extra) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: Sizes().large,
                      bottom: Sizes().large,
                    ),
                    child: IngredientDisplay(extra),
                  );
                },
              ),
          ],
        ),
        DolarPriceText(
          price: pack.price,
          textStyle: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
