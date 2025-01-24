import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/calculator_button_data.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.buttonData,
    required this.onTap,
  });

  final CalculatorButtonData buttonData;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes().roundedSmall),
        child: Container(
          color: buttonData.color,
          child: Center(
              child: buttonData.icon != null
                  ? Icon(buttonData.icon,
                      size: Theme.of(context).textTheme.headlineSmall?.fontSize,
                      color: buttonData.textColor)
                  : Text(
                      buttonData.text,
                      style: TextStyle(
                        color: buttonData.textColor,
                        fontSize:
                            Theme.of(context).textTheme.headlineSmall?.fontSize,
                      ),
                    )),
        ),
      ),
    );
  }
}
