import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/widgets/expansible_plate.dart';
import 'package:flutter/material.dart';

class ExpansiblePack extends StatelessWidget {
  const ExpansiblePack({super.key, required this.pack});

  final PlatePack pack;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ExpansionTile(
      leading: Text(
        pack.code,
        style: TextStyle(
          fontSize: theme.textTheme.titleMedium?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      title: Text(pack.title),
      children: [
        ...pack.platesSpread.map((Plate plate) {
          return ExpansiblePlate(plate: plate);
        }),
      ],
    );
  }
}
