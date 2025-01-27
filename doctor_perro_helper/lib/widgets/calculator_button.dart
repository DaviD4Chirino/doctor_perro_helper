import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/calculator_button_data.dart';
import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.buttonData,
    required this.onTap,
  });

  final CalculatorButtonData buttonData;
  final void Function(String buttonValue) onTap;

  get text => buttonData.dolarPriceMultiplier
      ? "x${removePaddingZero(SettingsModel().dolarPrice.toString())}"
      : buttonData.text;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(builder: (context, settings, child) {
      return InkWell(
        onTap: () => onTap(text),
        splashColor:
            Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(70),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes().roundedSmall),
          child: Container(
            color: buttonData.color,
            child: Center(
                child: buttonData.icon != null
                    ? Icon(buttonData.icon,
                        size:
                            Theme.of(context).textTheme.headlineSmall?.fontSize,
                        color: buttonData.textColor)
                    : Text(
                        text,
                        style: TextStyle(
                          color: buttonData.textColor,
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.fontSize,
                        ),
                      )),
          ),
        ),
      );
    });
  }
}
