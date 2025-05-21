import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color.fromRGBO(47, 128, 237, 1);
  static Color primaryAccent = const Color.fromRGBO(16, 42, 66, 1);
  static Color secondaryColor = const Color.fromRGBO(240, 136, 45, 1);
  static Color secondaryAccent = const Color.fromRGBO(179, 101, 34, 1);
  static Color backgroundColor = const Color.fromRGBO(241, 241, 241, 1);
  static Color backgroundAccent = const Color.fromRGBO(185, 185, 185, 1);
  static Color titleColor = const Color.fromRGBO(45, 45, 45, 1);
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
    labelSmall: TextStyle( // XSmallText
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.bold,
      fontSize: 10,
      letterSpacing: 0.5,
    ),
    bodySmall: TextStyle( // SmallText
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle( // SmallBodyText
      color: AppColors.textColor,
      fontWeight: FontWeight.bold,
      fontSize: 13,
      letterSpacing: 0.75,
    ),
    headlineSmall: TextStyle( // mediumText
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      letterSpacing: 1,
    ),
    titleSmall: TextStyle( // mediumBodyText
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      letterSpacing: 1.5,
    ),
    headlineMedium: TextStyle( // largeText
      color: AppColors.titleColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    titleMedium: TextStyle( // largeBodyText
      color: AppColors.titleColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
    titleLarge: TextStyle( // xLargeText
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      letterSpacing: 1.5,
    ),
    labelLarge: TextStyle( // couponCardText
      color: AppColors.titleColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.8,
    ),
  ),
);