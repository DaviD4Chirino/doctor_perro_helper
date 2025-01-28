import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DolarPriceText extends ConsumerWidget {
  const DolarPriceText({super.key, this.style});

  final TextStyle? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      removePaddingZero(ref.watch(dolarPriceNotifierProvider).toString()),
      style: style,
    );
  }
}
