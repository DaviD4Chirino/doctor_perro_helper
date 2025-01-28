import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/calculator_button_data.dart';
import 'package:doctor_perro_helper/utils/copy_clipboard.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:doctor_perro_helper/widgets/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

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

      toastification.show(
        title: const Text("Monto copiado"),
        autoCloseDuration: const Duration(seconds: 2),
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        primaryColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        showProgressBar: false,
        alignment: Alignment.bottomCenter,
      );
      return;
    }

    bool multipleDecimals = hasMultipleDecimals(newValue);
    if (multipleDecimals) {
      return;
    }
    questionString = replaceDuplicatedSymbols(newValue);
    questionString = addZeroBeforeDot(questionString);

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
      body: Center(
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: Sizes().xl),
                    reverse: true,
                    child: Text(
                      answerString,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displaySmall?.fontSize,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  )
                ],
              ),
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
      CalculatorButtonData(
        color: Colors.redAccent,
        text: "CE",
        value: "CLEAR",
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "copy",
        textColor: specialButtonTextColor,
        icon: Icons.copy,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "e",
        textColor: specialButtonTextColor,
        icon: Icons.backspace_outlined,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "%",
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
        text: "/",
        // icon: Icons.divide,
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
        text: "x",
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
        text: "—",
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        // Change to the dolar price
        text: "x60",
        dolarPriceMultiplier: true,
        textColor: specialButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: "0",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: normalButtonColor,
        text: ".",
        textColor: normalButtonTextColor,
      ),
      CalculatorButtonData(
        color: specialButtonColor,
        text: "+",
        textColor: specialButtonTextColor,
        icon: Icons.add,
      ),
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.1,
        crossAxisSpacing: Sizes().large,
        mainAxisSpacing: Sizes().large,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Sizes().xl,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: buttons.length,
      itemBuilder: (BuildContext context, int index) => CalculatorButton(
        buttonData: buttons[index],
        onTap: (buttonValue) {
          HapticFeedback.lightImpact();
          setState(() {
            question += buttonValue;
          });
        },
      ),
    );
  }
}
