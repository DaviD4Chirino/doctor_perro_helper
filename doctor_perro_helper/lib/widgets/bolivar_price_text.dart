import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BolivarPriceText extends ConsumerWidget {
  const BolivarPriceText({
    super.key,
    required this.price,
    this.textStyle,
  });
  final double price;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    final AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);

    final String calculatedBs = dolarPriceStream.maybeWhen(
      data: (data) => data.calculate(price).removePaddingZero(),
      orElse: () => "...",
    );
    return Text(
      "${calculatedBs}bs",
      style: textStyle ?? theme.textTheme.labelSmall,
    );
  }
}
