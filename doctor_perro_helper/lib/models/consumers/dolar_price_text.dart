import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DolarPriceText extends StatelessWidget {
  DolarPriceText({super.key, this.style});
  final RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(builder: (context, settings, child) {
      return Text(
        removePaddingZero(settings.dolarPrice.toString()),
        style: style,
      );
    });
  }
}
