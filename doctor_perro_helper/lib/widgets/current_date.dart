import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/utils/extensions/string_capitalize.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDateText extends StatelessWidget {
  CurrentDateText({super.key});

  // final DateTime now = DateTime.now();
  final String fullYear = DateFormat.MMMMd("es_ES").format(DateTime.now());
  final String week =
      DateFormat.EEEE("es_ES").format(DateTime.now()).capitalize();

  String getString() {
    return "$week, $fullYear";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes().xxl),
      child: Text(
        "$week, $fullYear",
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
