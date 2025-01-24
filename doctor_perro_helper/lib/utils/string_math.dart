import 'package:math_expressions/math_expressions.dart';

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
