import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This widget gives you the presented dolar and it calculates the bs price
/// below it
class DolarAndBolivarPriceText extends ConsumerWidget {
  const DolarAndBolivarPriceText({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    double calculatedBs =
        ref.read(dolarPriceNotifierProvider.notifier).calculate(price);
    String formattedBs = removePaddingZero(calculatedBs.toString());
    return Column(
      children: [
        Text(
          "${removePaddingZero(price.toString())}\$",
          style: TextStyle(
            fontSize: theme.textTheme.titleLarge?.fontSize,
          ),
        ),
        Text(
          "${formattedBs}bs",
          style: TextStyle(
            fontSize: theme.textTheme.labelSmall?.fontSize,
          ),
        ),
      ],
    );
  }
}
