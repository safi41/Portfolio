import 'package:flutter/material.dart';

class AppTheme {
  // Colors extracted from the attached design
  static const Color darkBackground = Color(0xFF1A1A1A); // Navigation bar / Dark text
  static const Color primaryOrange = Color(0xFFFD853A);  // Active state / 'Jenny' / Buttons
  static const Color accentPeach = Color(0xFFFEB273);   // Soft arch background
  static const Color textBlack = Color(0xFF171717);     // Main headlines
  static const Color ghostWhite = Color(0xFFF8F9FA);    // Page background

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryOrange,
      scaffoldBackgroundColor: Colors.white,

      colorScheme: const ColorScheme.light(
        primary: primaryOrange,
        secondary: darkBackground,
        tertiary: accentPeach,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),

      // Matching the dark, rounded Navigation Bar style
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // Styling buttons for that "Pill" shape seen in the design
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: const StadiumBorder(), // Fully rounded corners
        ),
      ),

      // Typography matching the bold, dark headings
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textBlack,
          fontWeight: FontWeight.w900,
          fontSize: 64,
          height: 1.1,
        ),
        bodyLarge: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
      ),
    );
  }
}