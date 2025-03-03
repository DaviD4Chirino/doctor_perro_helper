import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
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
    final AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);

    final String calculatedBs = dolarPriceStream.maybeWhen(
      data: (data) => data.calculate(price).removePaddingZero(),
      orElse: () => "...",
    );
    return Column(
      children: [
        Text(
          "${price.removePaddingZero()}\$",
          style: TextStyle(
            fontSize: theme.textTheme.titleLarge?.fontSize,
          ),
        ),
        Text(
          "${calculatedBs}bs",
          style: TextStyle(
            fontSize: theme.textTheme.labelSmall?.fontSize,
          ),
        ),
      ],
    );
  }
}
