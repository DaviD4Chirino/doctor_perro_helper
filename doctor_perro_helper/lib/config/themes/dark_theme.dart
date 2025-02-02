import 'package:doctor_perro_helper/config/themes/shared_theme_data.dart';
import 'package:flutter/material.dart';

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFF9B142),
  onPrimary: Color(0xFF140F0F),
  primaryContainer: Color(0xFFFFE4B4),
  onPrimaryContainer: Color(0xFF140F0F),
  secondary: Color(0xFFE99140),
  onSecondary: Color(0xFF140F0F),
  secondaryContainer: Color(0xFF815328),
  onSecondaryContainer: Color(0xFFF2F0E8),
  tertiary: Color(0xFFEE4845),
  onTertiary: Color(0xFFF2F0E8),
  tertiaryContainer: Color(0xFFF77E7C),
  onTertiaryContainer: Color(0xFF140F0F),
  error: Color(0xFFF30F03),
  onError: Color(0xFF4C100D),
  errorContainer: Color(0xFF661511),
  onErrorContainer: Color(0xFFE6ACA9),
  surface: Color(0xFF292929),
  onSurface: Color(0xFFF2F0E8),
  surfaceContainerHighest: Color(0xFF383838),
  onSurfaceVariant: Color(0xFFdedbe6),
  outline: Color(0xFFaaa7b3),
);

final sharedThemeData = SharedThemeData();

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  appBarTheme: sharedThemeData.appBarTheme(darkColorScheme),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  ),
);
