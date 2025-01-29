import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/calculator_button_data.dart';
import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorButton extends ConsumerWidget {
  const CalculatorButton({
    super.key,
    required this.buttonData,
    required this.onTap,
  });

  final CalculatorButtonData buttonData;
  final void Function(String buttonValue) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String text = buttonData.dolarPriceMultiplier
        ? "x${removePaddingZero(ref.watch(dolarPriceNotifierProvider).toString())}"
        : buttonData.text;
    return Container(
      decoration: BoxDecoration(
        color: buttonData.color,
        borderRadius: BorderRadius.circular(Sizes().roundedSmall),
      ),
      child: TextButton(
        onPressed: () => onTap(text),
        child: Center(
          child: buttonData.icon != null
              ? Icon(buttonData.icon,
                  size: Theme.of(context).textTheme.headlineSmall?.fontSize,
                  color: buttonData.textColor)
              : FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: buttonData.textColor,
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall?.fontSize,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
