import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:flutter/material.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';
import 'package:native_toast/native_toast.dart';
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
      Clipboard.setData(ClipboardData(text: answerString));

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
                  Text(
                    questionString,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleMedium?.fontSize,
                    ),
                  ),
                  Text(
                    answerString,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.displaySmall?.fontSize,
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
      ),
    ];

    Future<void> vibrate() async {
      await Haptics.vibrate(HapticsType.medium);
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.1,
        crossAxisSpacing: Sizes().large,
        mainAxisSpacing: Sizes().large,
      ),
      padding: EdgeInsets.only(
        left: Sizes().xl,
        right: Sizes().xl,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: buttons.length,
      itemBuilder: (BuildContext context, int index) => CalculatorButton(
        buttonData: buttons[index],
        onTap: () {
          setState(() {
            question += buttons[index].text;
            HapticFeedback.lightImpact();
          });
        },
      ),
    );
  }
}

String calculateExpression(String expression) {
  String finalExpression = expression.replaceAll("x", "*");
  finalExpression = finalExpression.replaceAll("—", "-");

  if (!isValidMathExpression(finalExpression)) {
    return "";
  }

  if (hasDivisionByZero(finalExpression)) {
    return "División entre cero";
  }

  Parser p = Parser();
  Expression exp = p.parse(finalExpression);
  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);

  return eval.toString();
}

bool isValidExpression(String expression) {
  // Regular expression to detect two or more consecutive symbols
  RegExp regex = RegExp(r'([+\-—*x/%]{2,})');

  // Check if the expression matches the regex
  return !regex.hasMatch(expression);
}

bool isValidCommaExpression(String expression) {
  // Regular expression to detect two or more consecutive commas
  RegExp regex = RegExp(r'(,{2,})');

  // Check if the expression matches the regex
  return !regex.hasMatch(expression);
}

bool isValidMathExpression(String expression) {
  RegExp regex =
      RegExp(r'^\s*-?\d+(\.\d+)?\s*([+\-%—x*/]\s*-?\d+(\.\d+)?\s*)*$');
  return regex.hasMatch(expression);
}

// Function to check if there is any division by zero in the expression
bool hasDivisionByZero(String expression) {
  RegExp divisionByZero = RegExp(r'/\s*0+(\.0+)?\s*');
  return divisionByZero.hasMatch(expression);
}

String replaceDuplicatedSymbols(String expression) {
  // Regular expression to detect two or more consecutive symbols
  RegExp regex = RegExp(r'([+\-—*x/%]{2,})');

  // Replace the duplicated symbols using replaceAllMapped
  return expression.replaceAllMapped(regex, (match) {
    String matchedText = match.group(0)!;
    /* // If the matched text contains '+-' specifically, replace with '-'
    if (matchedText.contains('+-')) {
      return '-';
    } */
    // Get the last character from the matched group
    String lastChar = matchedText[matchedText.length - 1];
    return lastChar;
  });
}

bool hasMultipleDecimals(String number) {
  // Regular expression to detect two or more consecutive dots
  RegExp regex = RegExp(r'\d*\.\d*\.\d*');

  // Check if the number matches the regex
  return regex.hasMatch(number);
}

String addZeroBeforeDot(String expression) {
  // Regular expression to find symbols followed by an empty dot
  RegExp regex = RegExp(r'([+\-—*x/%])(\.)');

  // Replace the matched pattern with the symbol followed by '0.'
  return expression.replaceAllMapped(regex, (match) {
    return '${match.group(1)}0${match.group(2)}';
  });
}

class CalculatorButtonData {
  CalculatorButtonData(
      {required this.color,
      required this.text,
      required this.textColor,
      this.value,
      this.icon});
  Color color;
  Color textColor;
  String text;

  IconData? icon;
  String? value;
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
