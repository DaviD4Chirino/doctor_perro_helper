import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/widgets/reusables/display_plate_diferencies.dart';
import 'package:flutter/material.dart';

class DisplayPackDiferencies extends StatelessWidget {
  const DisplayPackDiferencies(this.pack, {super.key});
  final PlatePack pack;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(pack.title),
        ...pack.plates.map(
          (plate) {
            final Plate differences = plate.getDifferences(plate.base);
            if (differences.extrasTitles != "" ||
                differences.ingredientsTitles != "") {
              return DisplayPlateDiferencies(plate);
            }
            return Container();
          },
        ),
      ],
    );
  }
}
