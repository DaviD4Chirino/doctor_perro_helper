import 'package:doctor_perro_helper/config/themes/dark_theme.dart';
import 'package:doctor_perro_helper/config/themes/light_theme.dart';
import 'package:doctor_perro_helper/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('es_ES').then((_) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      title: "Dr.Perro Helper",
      initialRoute: "/",
      routes: {"/": (BuildContext context) => Home()},
    );
  }
}
