import 'package:bible_app/constants/constants.dart';
import 'package:bible_app/view_model/font_size_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDarkTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: Get.find<FontSizeController>().selectedFont.value,
    scaffoldBackgroundColor: const Color(0xFF1B1E25),
    primaryColor: const Color(0xFF1B1E25),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1B1E25), // Dark fill color for text fields
      // hintStyle: const TextStyle(color: Colors.grey), // Hint text color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),

    // Card theme
    cardTheme: const CardTheme(
      color: Color(0xFF2C2F36), // Dark color for cards
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
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
