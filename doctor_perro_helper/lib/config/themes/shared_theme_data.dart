import 'package:flutter/material.dart';

class SharedThemeData {
  AppBarTheme appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        color: colorScheme.primary,
        /* titleTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 24.0,
        ), */
      );
}
