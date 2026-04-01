import 'package:flutter/material.dart';

// class AppTheme {
//   // --- Shared Colors (Official Flutter Brand Colors) ---
//   static const Color flutterBlue = Color(0xFF02569B);       // Classic Flutter Blue
//   static const Color flutterLightBlue = Color(0xFF13B9FD);  // Vibrant Flutter Cyan/Light Blue
//
//   // --- Light Aesthetic Colors ---
//   static const Color pureWhite = Color(0xFFFFFFFF);      // Crisp white for surfaces
//   static const Color backgroundWhite = Color(0xFFF8F9FA); // Very subtle off-white for depth
//   static const Color textDark = Color(0xFF0F172A);       // Slate 900 for high-contrast, readable text
//   static const Color textMutedDark = Color(0xFF64748B);  // Slate 500 for secondary text
//
//   // --- Dark Aesthetic Colors ---
//   static const Color deepSlate = Color(0xFF0F172A);      // Main background (Deep modern slate)
//   static const Color surfaceSlate = Color(0xFF1E293B);   // Elevated cards/nav bars
//   static const Color textLight = Color(0xFFF8FAFC);      // Crisp off-white text
//   static const Color textMutedLight = Color(0xFF94A3B8); // Soft slate gray for body text
//
//   // ==========================================
//   // LIGHT THEME (Crisp, Clean, Blue & White)
//   // ==========================================
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       primaryColor: flutterBlue,
//       scaffoldBackgroundColor: backgroundWhite, // Soft white background
//
//       colorScheme: const ColorScheme.light(
//         primary: flutterBlue,
//         secondary: pureWhite, // Navbars and cards are pure white for that clean iOS/Modern web look
//         tertiary: flutterLightBlue,
//         surface: pureWhite,
//         onPrimary: Colors.white,
//         onSecondary: textDark,
//         onSurface: textDark,
//       ),
//
//       appBarTheme: const AppBarTheme(
//         backgroundColor: pureWhite,
//         foregroundColor: flutterBlue, // Blue text/icons on white app bar
//         elevation: 0,
//       ),
//
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: flutterBlue,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//           shape: const StadiumBorder(),
//           elevation: 2, // Slight shadow to make the blue button pop off the white background
//         ),
//       ),
//
//       textTheme: const TextTheme(
//         displayLarge: TextStyle(
//           color: textDark,
//           fontWeight: FontWeight.w900,
//           fontSize: 64,
//           height: 1.1,
//         ),
//         bodyLarge: TextStyle(
//           color: textMutedDark,
//           fontSize: 16,
//           height: 1.5,
//         ),
//       ),
//     );
//   }
//
//   // ==========================================
//   // DARK THEME (Deep Slate & Vibrant Cyan)
//   // ==========================================
//   static ThemeData get darkTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       primaryColor: flutterLightBlue,
//       scaffoldBackgroundColor: deepSlate,
//
//       colorScheme: const ColorScheme.dark(
//         primary: flutterLightBlue, // Use the vibrant cyan for dark mode accents
//         secondary: surfaceSlate,
//         tertiary: flutterBlue,
//         surface: surfaceSlate,
//         onPrimary: deepSlate, // Dark text on the bright cyan buttons
//         onSecondary: textLight,
//         onSurface: textLight,
//       ),
//
//       appBarTheme: const AppBarTheme(
//         backgroundColor: deepSlate,
//         foregroundColor: textLight,
//         elevation: 0,
//       ),
//
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: flutterLightBlue, // Bright pop of cyan
//           foregroundColor: deepSlate, // Deep text for contrast
//           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//           shape: const StadiumBorder(),
//         ),
//       ),
//
//       textTheme: const TextTheme(
//         displayLarge: TextStyle(
//           color: textLight,
//           fontWeight: FontWeight.w900,
//           fontSize: 64,
//           height: 1.1,
//         ),
//         bodyLarge: TextStyle(
//           color: textMutedLight,
//           fontSize: 16,
//           height: 1.5,
//         ),
//       ),
//     );
//   }
// }













//
// import 'package:flutter/material.dart';
//
// class AppTheme {
//   // --- Shared Colors (The Olive Palette) ---
//   static const Color primaryOlive = Color(0xFF627538);   // Vibrant, earthy olive green
//   static const Color sageGreen = Color(0xFFA3B18A);      // Soft, light sage for accents
//
//   // --- Dark Aesthetic Colors ---
//   static const Color deepForestBg = Color(0xFF12160F);   // Main page background (Almost black with green tint)
//   static const Color surfaceOlive = Color(0xFF1E2617);   // Cards, Nav bars (Elevated dark forest)
//   static const Color textWarmLight = Color(0xFFF2F4EB);  // Main headlines (Warm off-white)
//   static const Color textMutedSage = Color(0xFF9FA88F);  // Body text (Soft grayish-green)
//
//   // --- Light Aesthetic Colors ---
//   static const Color darkNavBg = Color(0xFF283618);      // Navigation bar in light mode (Deep olive/pine)
//   static const Color textDark = Color(0xFF1A1F14);       // Main headlines (Very dark green, almost black)
//   static const Color ghostWarmWhite = Color(0xFFF9FBF4); // Page background (Hint of warmth)
//
//   // ==========================================
//   // LIGHT THEME
//   // ==========================================
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       primaryColor: primaryOlive,
//       scaffoldBackgroundColor: ghostWarmWhite, // Warmer white to complement the green
//
//       colorScheme: const ColorScheme.light(
//         primary: primaryOlive,
//         secondary: darkNavBg,
//         tertiary: sageGreen,
//         surface: Colors.white,
//         onPrimary: Colors.white,
//         onSecondary: Colors.white,
//         onSurface: textDark,
//       ),
//
//       appBarTheme: const AppBarTheme(
//         backgroundColor: darkNavBg,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: primaryOlive,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//           shape: const StadiumBorder(),
//         ),
//       ),
//
//       textTheme: const TextTheme(
//         displayLarge: TextStyle(
//           color: textDark,
//           fontWeight: FontWeight.w900,
//           fontSize: 64,
//           height: 1.1,
//         ),
//         bodyLarge: TextStyle(
//           color: Colors.black54,
//           fontSize: 16,
//           height: 1.5,
//         ),
//       ),
//     );
//   }
//
//   // ==========================================
//   // DARK THEME
//   // ==========================================
//   static ThemeData get darkTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       primaryColor: primaryOlive,
//       scaffoldBackgroundColor: deepForestBg,
//
//       colorScheme: const ColorScheme.dark(
//         primary: sageGreen, // Lighter sage green for better contrast in dark mode
//         secondary: surfaceOlive,
//         tertiary: primaryOlive,
//         surface: surfaceOlive,
//         onPrimary: Colors.black, // Dark text on the light sage buttons
//         onSecondary: textWarmLight,
//         onSurface: textWarmLight,
//       ),
//
//       appBarTheme: const AppBarTheme(
//         backgroundColor: deepForestBg,
//         foregroundColor: textWarmLight,
//         elevation: 0,
//       ),
//
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: sageGreen, // Bright sage button stands out in the dark
//           foregroundColor: Colors.black, // High contrast text
//           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//           shape: const StadiumBorder(),
//         ),
//       ),
//
//       textTheme: const TextTheme(
//         displayLarge: TextStyle(
//           color: textWarmLight,
//           fontWeight: FontWeight.w900,
//           fontSize: 64,
//           height: 1.1,
//         ),
//         bodyLarge: TextStyle(
//           color: textMutedSage,
//           fontSize: 16,
//           height: 1.5,
//         ),
//       ),
//     );
//   }
// }
//
//









import 'package:flutter/material.dart';

class AppTheme {
  // --- Shared Colors (Used in both themes) ---
  static const Color primaryOrange = Color(0xFFFD853A);  // Active state / Buttons
  static const Color accentPeach = Color(0xFFFEB273);    // Soft arch background

  // --- Dark Aesthetic Colors ---
  static const Color deepBackground = Color(0xFF0F0F13); // Main page background
  static const Color surfaceDark = Color(0xFF1E1E24);    // Cards, Nav bars
  static const Color textLight = Color(0xFFF8F9FA);      // Main headlines (Off-white)
  static const Color textMuted = Color(0xFFA0A0A5);      // Body text (Soft gray)

  // --- Light Aesthetic Colors ---
  static const Color darkBackground = Color(0xFF1A1A1A); // Navigation bar in light mode
  static const Color textBlack = Color(0xFF171717);      // Main headlines
  static const Color ghostWhite = Color(0xFFF8F9FA);     // Page background

  // ==========================================
  // LIGHT THEME
  // ==========================================
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
        onSurface: textBlack, // Ensures default text is dark
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: const StadiumBorder(),
        ),
      ),

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
          height: 1.5,
        ),
      ),
    );
  }

  // ==========================================
  // DARK THEME
  // ==========================================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryOrange,
      scaffoldBackgroundColor: deepBackground,

      colorScheme: const ColorScheme.dark(
        primary: primaryOrange,
        secondary: surfaceDark,
        tertiary: accentPeach,
        surface: surfaceDark,
        onPrimary: Colors.white,
        onSecondary: textLight,
        onSurface: textLight, // Ensures default text is light
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: deepBackground,
        foregroundColor: textLight,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
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
          color: textMuted,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}