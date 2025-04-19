import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color.fromRGBO(47, 128, 237, 1);
  static Color primaryAccent = const Color.fromRGBO(16, 42, 66, 1);
  static Color secondaryColor = const Color.fromRGBO(240, 136, 45, 1);
  static Color secondaryAccent = const Color.fromRGBO(179, 101, 34, 1);
  static Color backgroundColor = const Color.fromRGBO(230, 230, 230, 1);
  static Color backgroundAccent = const Color.fromRGBO(185, 185, 185, 1);
  static Color titleColor = const Color.fromRGBO(51, 51, 51, 1);
  static Color textColor = const Color.fromRGBO(30, 30, 30, 1);
  static Color successColor = const Color.fromRGBO(52, 180, 57, 1);
  static Color highlightColor = const Color.fromRGBO(212, 172, 13, 1);
  static Color dangerColor = const Color.fromRGBO(202, 43, 43, 1);
}

ThemeData primaryTheme = ThemeData(
  // seed color
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
  ),

  // scaffold color
  scaffoldBackgroundColor: AppColors.backgroundAccent,

  // app bar theme color
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: AppColors.textColor,
    surfaceTintColor: Colors.transparent,
  ),

  // text theme
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: AppColors.titleColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    titleMedium: TextStyle(
      color: AppColors.titleColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
    bodySmall: TextStyle(
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      letterSpacing: 0.5,
    ),
    headlineSmall: TextStyle(
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      letterSpacing: 1,
    ),
    titleSmall: TextStyle(
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      letterSpacing: 1.5,
    ),
    titleLarge: TextStyle(
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      letterSpacing: 1.5,
    )
  ),
);