import 'package:flutter/material.dart';

class DoradoColors {
  static late Color backgroundOrange;
  static late Color backgroundBlue;
  static late Color primary;
  static late Color secondary;
  static late Color backgroundWhite;
  static late Color black;
  static late Color textColor;

  static late Color gray100;
  static late Color gray200;
  static late Color gray300;
  static late Color gray400;
  static late Color gray500;
  static late Color gray600;
  static late Color gray700;
  static late Color gray800;
  static late Color gray900;

  static late Color error;
  static late Color success;
  static late Color warning;

  static void setLightTheme() {
    backgroundOrange = const Color(0xFFFFB200);
    backgroundBlue = const Color(0xFFE0F8FA);
    primary = const Color(0xFFFFB200);
    secondary = const Color(0xFF4FD1E2);
    backgroundWhite = Colors.white;
    black = Colors.black;
    textColor = Colors.black;

    gray100 = const Color(0xFFF7FAFC);
    gray200 = const Color(0xFFEDF2F7);
    gray300 = const Color(0xFFE2E8F0);
    gray400 = const Color(0xFFCBD5E0);
    gray500 = const Color(0xFFA0AEC0);
    gray600 = const Color(0xFF718096);
    gray700 = const Color(0xFF4A5568);
    gray800 = const Color(0xFF2D3748);
    gray900 = const Color(0xFF1A202C);

    error = const Color(0xFFe53e3e);
    success = const Color(0xFF38A169);
    warning = const Color(0xFFDD6B20);
  }

  static void setDarkTheme() {
    backgroundOrange = const Color(0xFF4A2C00);
    backgroundBlue = const Color(0xFF102124);
    primary = const Color(0xFFFFA726);
    secondary = const Color(0xFF00BCD4);
    backgroundWhite = const Color(0xFF1E1E28);
    black = Colors.black;
    textColor = Colors.white;

    gray100 = const Color(0xFF1A202C);
    gray200 = const Color(0xFF2D3748);
    gray300 = const Color(0xFF4A5568);
    gray400 = const Color(0xFF718096);
    gray500 = const Color(0xFFA0AEC0);
    gray600 = const Color(0xFFCBD5E0);
    gray700 = const Color(0xFFE2E8F0);
    gray800 = const Color(0xFFEDF2F7);
    gray900 = const Color(0xFFF7FAFC);

    error = const Color(0xFFEF5350);
    success = const Color(0xFF66BB6A);
    warning = const Color(0xFFFFA726);
  }
}
