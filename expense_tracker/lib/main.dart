import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';

// Light Theme Colors
final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF16A34A),
  brightness: Brightness.light,
);

// Dark Theme Colors
final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF4ADE80),
  brightness: Brightness.dark,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,

      // Light Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: const Color(0xFFF4F7F5),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF16A34A),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          shadowColor: Colors.black12,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF16A34A),
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF14532D),
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF166534),
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF374151)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF16A34A),
          foregroundColor: Colors.white,
          elevation: 4,
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF16A34A), width: 2),
          ),
        ),

        dividerTheme: const DividerThemeData(color: Color(0xFFE5E7EB), thickness: 1),
      ),

      // Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111827),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF064E3B),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),

        cardTheme: CardThemeData(
          color: const Color(0xFF1F2937),
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4ADE80),
            foregroundColor: const Color(0xFF052E16),
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF4ADE80),
          foregroundColor: Color(0xFF052E16),
          elevation: 4,
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1F2937),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF4ADE80), width: 2),
          ),
        ),
      ),

      // Automatically follows the device's theme setting.
      themeMode: ThemeMode.system,

      home: const Expenses(),
    );
  }
}
