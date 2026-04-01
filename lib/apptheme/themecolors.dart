import 'package:flutter/material.dart';

class AppTheme {
  // --- Shared Colors (Official Flutter Brand Colors) ---
  static const Color flutterBlue = Color(0xFF02569B);       // Classic Flutter Blue
  static const Color flutterLightBlue = Color(0xFF13B9FD);  // Vibrant Flutter Cyan/Light Blue

  // --- Light Aesthetic Colors ---
  static const Color pureWhite = Color(0xFFFFFFFF);      // Crisp white for surfaces
  static const Color backgroundWhite = Color(0xFFF8F9FA); // Very subtle off-white for depth
  static const Color textDark = Color(0xFF0F172A);       // Slate 900 for high-contrast, readable text
  static const Color textMutedDark = Color(0xFF64748B);  // Slate 500 for secondary text

  // --- Dark Aesthetic Colors ---
  static const Color deepSlate = Color(0xFF0F172A);      // Main background (Deep modern slate)
  static const Color surfaceSlate = Color(0xFF1E293B);   // Elevated cards/nav bars
  static const Color textLight = Color(0xFFF8FAFC);      // Crisp off-white text
  static const Color textMutedLight = Color(0xFF94A3B8); // Soft slate gray for body text

  // ==========================================
  // LIGHT THEME (Crisp, Clean, Blue & White)
  // ==========================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: flutterBlue,
      scaffoldBackgroundColor: backgroundWhite, // Soft white background

      colorScheme: const ColorScheme.light(
        primary: flutterBlue,
        secondary: pureWhite, // Navbars and cards are pure white for that clean iOS/Modern web look
        tertiary: flutterLightBlue,
        surface: pureWhite,
        onPrimary: Colors.white,
        onSecondary: textDark,
        onSurface: textDark,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: pureWhite,
        foregroundColor: flutterBlue, // Blue text/icons on white app bar
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: flutterBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: const StadiumBorder(),
          elevation: 2, // Slight shadow to make the blue button pop off the white background
        ),
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textDark,
          fontWeight: FontWeight.w900,
          fontSize: 64,
          height: 1.1,
        ),
        bodyLarge: TextStyle(
          color: textMutedDark,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }

  // ==========================================
  // DARK THEME (Deep Slate & Vibrant Cyan)
  // ==========================================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: flutterLightBlue,
      scaffoldBackgroundColor: deepSlate,

      colorScheme: const ColorScheme.dark(
        primary: flutterLightBlue, // Use the vibrant cyan for dark mode accents
        secondary: surfaceSlate,
        tertiary: flutterBlue,
        surface: surfaceSlate,
        onPrimary: deepSlate, // Dark text on the bright cyan buttons
        onSecondary: textLight,
        onSurface: textLight,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: deepSlate,
        foregroundColor: textLight,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: flutterLightBlue, // Bright pop of cyan
          foregroundColor: deepSlate, // Deep text for contrast
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: const StadiumBorder(),
        ),
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textLight,
          fontWeight: FontWeight.w900,
          fontSize: 64,
          height: 1.1,
        ),
        bodyLarge: TextStyle(
          color: textMutedLight,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}













