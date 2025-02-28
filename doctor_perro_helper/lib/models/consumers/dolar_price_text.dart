import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/models/providers/streams/user_data_provider_stream.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DolarPriceText extends ConsumerWidget {
  const DolarPriceText({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);

    return Text(
      dolarPriceStream.when(
        data: (DolarPriceInBsDoc data) => data.latestValue.removePaddingZero(),
        error: (e, st) => "Err",
        loading: () => "...",
      ),
      style: style,
    );
  }
}
