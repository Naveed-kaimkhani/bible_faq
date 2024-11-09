import 'package:bible_faq/constants/constants.dart';
import 'package:flutter/material.dart';

class AppLightTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: "lato_regular",
    scaffoldBackgroundColor: const Color(0xff17A2B8),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff17A2B8)),
    useMaterial3: true,

    //card theme
    cardTheme: const CardTheme(
      color: AppColors.white,
    ),
    filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(color: AppColors.aquaBlue),
        ),
      ),
    ),
  );
}
