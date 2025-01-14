import 'package:doctor_perro_helper/config/themes/shared_theme_data.dart';
import 'package:flutter/material.dart';

// TODO: Fix the mistaching Light color Scheme
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFEDB8F5),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFCBC0E6),
  onPrimaryContainer: Color(0xFF201933),
  secondary: Color(0xFF514097),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDCD8E6),
  onSecondaryContainer: Color(0xFF2C2933),
  tertiary: Color(0xFF61B0C9),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFE6CDD5),
  onTertiaryContainer: Color(0xFF332227),
  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFE6ACA9),
  onErrorContainer: Color(0xFF330B09),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF323233),
  surfaceContainerHighest: Color(0xFFe0dee6),
  onSurfaceVariant: Color(0xFF5e5c66),
  outline: Color(0xFF8e8999),
);

final sharedThemeData = SharedThemeData();

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  appBarTheme: sharedThemeData.appBarTheme(lightColorScheme),
);
