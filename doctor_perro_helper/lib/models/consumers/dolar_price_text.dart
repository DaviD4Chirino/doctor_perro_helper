import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DolarPriceText extends StatelessWidget {
  const DolarPriceText({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(builder: (context, settings, child) {
      return Text(
        settings.dolarPrice,
        style: style,
      );
    });
  }
}
