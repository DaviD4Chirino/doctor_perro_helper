import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/widgets/bolivar_price_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This widget gives you the presented dolar and it calculates the bs price
/// below it
class DolarAndBolivarPriceText extends StatelessWidget {
  const DolarAndBolivarPriceText({
    super.key,
    required this.price,
    this.bolivaresTextStyle,
    this.dolarPriceTextStyle,
  });

  final double price;
  final TextStyle? dolarPriceTextStyle;
  final TextStyle? bolivaresTextStyle;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Text(
          "${price.removePaddingZero()}\$",
          style: dolarPriceTextStyle ?? theme.textTheme.titleLarge,
        ),
        BolivarPriceText(
          price: price,
          textStyle: bolivaresTextStyle,
        ),
      ],
    );
  }
}
