import 'package:doctor_perro_helper/models/consumers/bolivar_price_text.dart';
import 'package:doctor_perro_helper/widgets/dolar_price_text.dart';
import 'package:flutter/material.dart';

/// This widget gives you the presented dolar and it calculates the bs price below it
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
    return Column(
      children: [
        DolarPriceText(
          price: price,
          textStyle: dolarPriceTextStyle,
        ),
        BolivarPriceText(
          price: price,
          textStyle: bolivaresTextStyle,
        ),
      ],
    );
  }
}
