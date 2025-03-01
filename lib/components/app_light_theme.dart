import 'package:bible_app/constants/constants.dart';
import 'package:bible_app/view_model/font_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLightTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: Get.find<FontSizeController>().selectedFont.value,
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
