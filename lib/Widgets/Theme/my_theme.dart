import 'package:flutter/material.dart';

class MyTheme {

  static const String interFont = "Inter";
  static const String geistFont = "Geist";

  static const Color primaryColor = Color(0xFF1D8EF5);
  static const Color secondaryColor = Color(0xFFF8FAFC);
  static const Color tertiaryColor = Color(0xFFE2E8F0);
  static const Color neutralColor = Color(0xFF1E293B);

  // static final TextTheme _baseTextTheme = TextTheme(); //will fill it when ui is finalized

  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
    onSurface: neutralColor,
  );

  static final TextTheme textTheme = TextTheme(
    
    // Major Page Headers (e.g., "Good morning, Julian.")
    headlineMedium: const TextStyle(
      fontFamily: geistFont,
      fontSize: 28.0,
      fontWeight: FontWeight.w300, // Light
      letterSpacing: -0.5, // tracking-tight
    ),

    // App Bar Titles / Important Names (e.g., "Beliz")
    titleLarge: const TextStyle(
      fontFamily: geistFont,
      fontSize: 18.0,
      fontWeight: FontWeight.w600, // Semi-bold
      letterSpacing: -0.5,
    ),

    // Standard List Items / Task Names (e.g., "Client alignment call")
    titleMedium: const TextStyle(
      fontFamily: geistFont,
      fontSize: 16.0,
      fontWeight: FontWeight.w400, // Normal
    ),

    // Headline Subtitles (e.g., "FRIDAY, JULY 12")
    titleSmall: const TextStyle(
      fontFamily: geistFont,
      fontSize: 14.0, // text-sm
      fontWeight: FontWeight.w500, // font-medium
      letterSpacing: 1.5, // tracking-widest
    ),

    // Standard Body Text
    bodyMedium: const TextStyle(
      fontFamily: geistFont,
      fontSize: 14.0,
      fontWeight: FontWeight.w400, // Normal
    ),

    // Section Headers (e.g., "CURRENT FOCUS", "UPCOMING")
    labelLarge: const TextStyle(
      fontFamily: geistFont,
      fontSize: 12.0, // text-xs
      fontWeight: FontWeight.w600, // Semi-bold
      letterSpacing: 2.0, // tracking-[0.2em]
      // Note: Use .toUpperCase() on the Text widget itself for uppercase
    ),

    // Time blocks & Nav Items (e.g., "09:00 — 11:00", "Tasks")
    labelMedium: const TextStyle(
      fontFamily: geistFont,
      fontSize: 11.0, 
      fontWeight: FontWeight.w500, // Medium
      letterSpacing: 1.0, // tracking-wider
    ),

    // Tiny Tags & Badges (e.g., "3 LEFT", "FRI")
    labelSmall: const TextStyle(
      fontFamily: geistFont,
      fontSize: 10.0,
      fontWeight: FontWeight.w700, // Bold
    ),
  ).apply(
    // This ensures all text defaults to your neutral dark color
    bodyColor: neutralColor,
    displayColor: neutralColor,
  );

  static ThemeData lightTheme = ThemeData(
    fontFamily: geistFont,
    colorScheme: lightScheme,
    textTheme: textTheme,
  );
}