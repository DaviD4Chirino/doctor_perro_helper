import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:flutter/material.dart';

class DolarPriceText extends StatelessWidget {
  const DolarPriceText({super.key, required this.price, this.textStyle});
  final double price;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(
      "${price.removePaddingZero()}\$",
      style: textStyle ?? theme.textTheme.titleLarge,
    );
  }
}
