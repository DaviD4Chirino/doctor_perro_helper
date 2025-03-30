import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentDolarPriceText extends ConsumerWidget {
  const CurrentDolarPriceText({super.key, this.style, this.text});

  final TextStyle? style;

  /// this is if you want the text to be formatted a specific way
  /// like putting bs at the end of the value
  final String Function(String latestValue)? text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);

    return Text(
      dolarPriceStream.when(
        data: (DolarPriceInBsDoc data) => text != null
            ? text!(data.latestValue.removePaddingZero())
            : data.latestValue.removePaddingZero(),
        error: (e, st) => "Err",
        loading: () => "...",
      ),
      style: style,
    );
  }
}
