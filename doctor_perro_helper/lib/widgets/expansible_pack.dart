import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:flutter/material.dart';

class ExpansiblePack extends StatelessWidget {
  const ExpansiblePack({super.key, required this.pack});

  final PlatePack pack;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ExpansionTile(
      title: Text(pack.name),
    );
  }
}
