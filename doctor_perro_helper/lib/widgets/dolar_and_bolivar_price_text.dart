import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This widget gives you the presented dolar and it calculates the bs price
/// below it
class DolarAndBolivarPriceText extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    final AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);

    final String calculatedBs = dolarPriceStream.maybeWhen(
      data: (data) => data
          .calculate(double.parse(price.toStringAsFixed(2)))
          .removePaddingZero(),
      orElse: () => "...",
    );
    return Column(
      children: [
        Text(
          "${double.parse(price.toStringAsFixed(2)).removePaddingZero()}\$",
          style: dolarPriceTextStyle ?? theme.textTheme.titleLarge,
        ),
        Text(
          "${calculatedBs}bs",
          style: bolivaresTextStyle ?? theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}
