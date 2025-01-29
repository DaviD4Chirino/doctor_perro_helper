import 'package:doctor_perro_helper/config/themes/shared_theme_data.dart';
import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFFD9D43),
  onPrimary: Color(0xFF140F0F),
  primaryContainer: Color(0xFFFFCC7E),
  onPrimaryContainer: Color(0xFF201933),
  secondary: Color(0xFFFFBD80),
  onSecondary: Color(0xFF140F0F),
  secondaryContainer: Color(0xFFFFA958),
  onSecondaryContainer: Color(0xFF140F0F),
  tertiary: Color(0xFFEE4845),
  onTertiary: Color(0xFFF2F0E8),
  tertiaryContainer: Color(0xFFE6CDD5),
  onTertiaryContainer: Color(0xFF332227),
  error: Color(0xFFB3261E),
  onError: Color(0xFF4C100D),
  errorContainer: Color(0xFFE6ACA9),
  onErrorContainer: Color(0xFF330B09),
  surface: Color(0xFFE9ECEF),
  onSurface: Color(0xFF212529),
  surfaceContainerHighest: Color(0xFFFEFDFF),
  onSurfaceVariant: Color(0xFF212529),
  outline: Color(0xFF212529),
);

final sharedThemeData = SharedThemeData();

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  appBarTheme: sharedThemeData.appBarTheme(lightColorScheme),
);
