import 'package:flutter/material.dart';

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
