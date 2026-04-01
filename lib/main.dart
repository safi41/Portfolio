import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porfolio/portfolio_page/portfolio.dart';
import 'Controller.dart';
import 'apptheme/themecolors.dart'; // Make sure to import your AppTheme class

void main() {
  // ProviderScope is required for Riverpod to work
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the theme state
    final isDarkMode = ref.watch(isDarkModeProvider);

    return MaterialApp(
      title: 'Sufian Portfolio',
      debugShowCheckedModeBanner: false,

      // 2. Set up your Light and Dark themes from the AppTheme class
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // 3. Dynamically switch based on the Riverpod state
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(scrollbars: false),
          child: child!,
        );
      },

      home: const PortfolioHeroPage(),
    );
  }
}