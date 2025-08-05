import 'package:flutter/material.dart';
import 'dorado_colors.dart';

final ThemeData doradoTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: DoradoColors.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: DoradoColors.primary,
    primary: DoradoColors.primary,
    secondary: DoradoColors.secondary,
    surface: DoradoColors.backgroundWhite,
    error: DoradoColors.error,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: DoradoColors.gray100,
  appBarTheme: AppBarTheme(
    backgroundColor: DoradoColors.primary,
    foregroundColor: DoradoColors.backgroundWhite,
    elevation: 0,
  ),
  textTheme:  TextTheme(
    bodyLarge: TextStyle(color: DoradoColors.gray900),
    bodyMedium: TextStyle(color: DoradoColors.gray800),
    titleLarge: TextStyle(
      color: DoradoColors.primary,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DoradoColors.primary,
      foregroundColor: DoradoColors.backgroundWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);
