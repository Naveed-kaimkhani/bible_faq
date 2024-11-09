import 'package:bible_faq/constants/constants.dart';
import 'package:flutter/material.dart';

class AppDarkTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
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
    // List tile theme
    // listTileTheme: const ListTileThemeData(
    //   textColor: Colors.white,
    //   iconColor: Colors.white,
    //   tileColor: Color(0xFF2C2F36), // Tile background color
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(12)),
    //   ),
    // ),

    // Icon theme
    // iconTheme: const IconThemeData(
    //   color: Colors.white,
    // ),

    // Floating action button theme
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   backgroundColor: Color(0xFF2C2F36),
    //   foregroundColor: Colors.white,
    // ),

    // Elevated button theme
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     // primary: const Color(0xFF2C2F36),
    //     // onPrimary: Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //   ),
    // ),
  );
}
