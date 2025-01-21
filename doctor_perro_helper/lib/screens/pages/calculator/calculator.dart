import 'dart:developer';

import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:flutter/material.dart';

class DolarCalculator extends StatefulWidget {
  const DolarCalculator({super.key});

  @override
  State<DolarCalculator> createState() => _DolarCalculatorState();
}

class _DolarCalculatorState extends State<DolarCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: gridButtons(),
            ),
          ],
        ),
      ),
    );
  }

  GridView gridButtons() {
    final Color specialButtonColor = Theme.of(context).colorScheme.secondary;
    final Color specialButtonTextColor =
        Theme.of(context).colorScheme.onSecondary;

    final Color normalButtonColor =
        Theme.of(context).colorScheme.surfaceContainerHighest;
    final Color normalButtonTextColor = Theme.of(context).colorScheme.onSurface;

    final List<CalculatorButtonData> buttons = [
      /* CalculatorButtonData(
        color: Colors.lightGreenAccent,
        text: "C",
        textColor: Colors.black,
      ),
      CalculatorButtonData(
        color: Colors.redAccent,
        text: "DEL",
        textColor: Colors.white,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "%",
        textColor: specialButtonTextColor,
      ), */

      CalculatorButtonData(
        color: normalButtonColor,
        text: "9",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "8",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "7",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "/",
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "6",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "5",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "4",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "x",
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "3",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "2",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "1",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "—",
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "Copy",
        textColor: specialButtonTextColor,
        icon: Icons.copy,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "0",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: ",",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "+",
        textColor: specialButtonTextColor,
      ),
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
      ),
      padding: EdgeInsets.only(
        left: Sizes().xl,
        right: Sizes().xl,
        top: Sizes().xxxl * 2,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: buttons.length,
      itemBuilder: (BuildContext context, int index) => CalculatorButton(
        buttonData: buttons[index],
        onTap: () {
          log(buttons[index].text);
        },
      ),
    );
  }
}

class CalculatorButtonData {
  CalculatorButtonData(
      {required this.color,
      required this.text,
      required this.textColor,
      this.icon});
  Color color;
  Color textColor;
  String text;

  IconData? icon;
}

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

class CalculatorButtonIcon extends StatelessWidget {
  const CalculatorButtonIcon({
    super.key,
    required this.buttonData,
    required this.onTap,
    required this.icon,
  });

  final CalculatorButtonData buttonData;
  final IconData icon;
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
            child: Icon(icon,
                size: Theme.of(context).textTheme.headlineSmall?.fontSize,
                color: buttonData.textColor),
          ),
        ),
      ),
    );
  }
}
