import 'package:doctor_perro_helper/models/calculator_button_data.dart';
import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorButton extends ConsumerWidget {
  const CalculatorButton({
    super.key,
    required this.buttonData,
    required this.onTap,
    this.onLongPress,
  });

  final CalculatorButtonData buttonData;
  final void Function(String buttonValue) onTap;
  final void Function(String buttonValue)? onLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);

    AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);

    String text = buttonData.dolarPriceMultiplier
        ? dolarPriceStream.maybeWhen(
            data: (data) => "x${data.latestValue.removePaddingZero()}",
            orElse: () => "x0",
          )
        : buttonData.text;

    return FilledButton(
      onPressed: () => onTap(text),
      onLongPress: () => onLongPress!(text),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(buttonData.color),
        foregroundColor: WidgetStateProperty.all(buttonData.textColor),
      ),
      child: Center(
        child: buttonData.icon != null
            ? Icon(buttonData.icon,
                size: theme.textTheme.headlineSmall?.fontSize,
                color: buttonData.textColor)
            : FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  text,
                  style: TextStyle(
                    color: buttonData.textColor,
                    fontSize: theme.textTheme.headlineSmall?.fontSize,
                  ),
                ),
              ),
      ),
    );
  }
}
