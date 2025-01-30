import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/calculator_button_data.dart';
import 'package:doctor_perro_helper/utils/copy_clipboard.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:doctor_perro_helper/utils/toast_message_helper.dart';
import 'package:doctor_perro_helper/widgets/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class DolarCalculator extends StatefulWidget {
  const DolarCalculator({super.key});

  @override
  State<DolarCalculator> createState() => _DolarCalculatorState();
}

class _DolarCalculatorState extends State<DolarCalculator> {
  String questionString = "";
  String answerString = "0";

  String get question {
    return questionString;
  }

  set question(String newValue) {
    if (newValue.contains("e")) {
      if (questionString.isEmpty) {
        return;
      }
      questionString = newValue.substring(0, questionString.length - 1);
      if (questionString.isEmpty) {
        answerString = "0";
        questionString = "";
        return;
      }
      updateAnswerString();
      return;
    }

    if (newValue.contains("CE")) {
      questionString = "";
      answerString = "0";
      return;
    }

    if (newValue.contains("copy")) {
      copy(answerString);
      ToastMessage.success(title: const Text("Monto copiado"));
      return;
    }

    bool multipleDecimals = hasMultipleDecimals(newValue);
    if (multipleDecimals) {
      return;
    }
    questionString = replaceDuplicatedSymbols(newValue);
    questionString = addZeroBeforeDot(questionString);

    if (newValue.contains("=")) {
      updateAnswerString();
      questionString = answerString;
      return;
    }

    updateAnswerString();
  }

  void updateAnswerString() {
    String calculatedExpression = calculateExpression(questionString);

    if (calculatedExpression.isEmpty) {
      // if its empty, usually a invalid operation, we want to NOT update the answer
      return;
    }

    answerString = calculateExpression(questionString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                textBaseline: TextBaseline.ideographic,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: Sizes().xl),
                    child: Text(
                      questionString,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize,
                      ),
                    ),
                  ),
                  InkWell(
                    onLongPress: () => setState(() => question += "copy"),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: Sizes().xl),
                      reverse: true,
                      child: Text(
                        answerString,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.fontSize,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  )
                ],
              ),
            ),
            // GridButtons
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Sizes().large,
                  right: Sizes().large,
                  bottom: Sizes().large,
                ),
                child: gridButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LayoutGrid gridButtons() {
    final Color specialButtonColor = Theme.of(context).colorScheme.secondary;
    final Color specialButtonTextColor =
        Theme.of(context).colorScheme.onSecondary;

    final Color normalButtonColor =
        Theme.of(context).colorScheme.surfaceContainerHighest;
    final Color normalButtonTextColor = Theme.of(context).colorScheme.onSurface;

    final List<CalculatorButtonData> buttons = [
      CalculatorButtonData(
        color: Theme.of(context).colorScheme.tertiary,
        text: "CE",
        value: "CLEAR",
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: Theme.of(context).colorScheme.primary,
        text: "x60",
        textColor: specialButtonTextColor,
        dolarPriceMultiplier: true,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "%",
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "/",
        // icon: Icons.divide,
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "7",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "8",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "9",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "x",
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "4",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "5",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "6",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "—",
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "1",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "2",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "3",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "+",
        textColor: specialButtonTextColor,
        icon: Icons.add,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        // Change to the dolar price
        text: ".",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "0",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "e",
        textColor: normalButtonTextColor,
        icon: Icons.backspace_outlined,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "=",
        textColor: specialButtonTextColor,
      ),
    ];
    return LayoutGrid(
      columnSizes: [1.fr, 1.fr, 1.fr, 1.fr],
      rowSizes: [1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
      columnGap: Sizes().large,
      rowGap: Sizes().large,
      children: [
        ...buttons.map(
          (button) => CalculatorButton(
            buttonData: button,
            onTap: (String value) {
              HapticFeedback.lightImpact();
              setState(() {
                question += value;
              });
            },
          ),
        )
      ],
    );
  }
}
