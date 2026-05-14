import 'package:flutter/material.dart';

class MyTheme {

  static const String interFont = "Inter";
  static const String geistFont = "Geist";

  static const Color primaryColor = Color(0xFF1D8EF5);
  static const Color secondaryColor = Color(0xFFF8FAFC);
  static const Color tertiaryColor = Color(0xFFE2E8F0);
  static const Color neutralColor = Color(0xFF1E293B);

  // Schedule palette
  static const Color scheduleBg       = Color(0xFFF5F6FA);
  static const Color schedulePurple   = Color(0xFF7B6CF6);
  static const Color scheduleCardTint = Color(0xFFF7F6FF);
  static const Color scheduleFab      = Color(0xFF1E3A6E);

  // Auth / Sign-up palette
  static const Color signUpBg = Color(0xFFEBECF8);
  static const Color signUpTeal = Color(0xFF0D7A7A);
  static const Color signUpGradientStart = Color(0xFF9477F5);
  static const Color signUpGradientEnd = Color(0xFF5AD9F5);
  static const Color signUpFieldBorder = Color(0xFFE4E7F2);
  static const Color signUpSubtitle = Color(0xFF8892AB);

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
      fontWeight: FontWeight.w500, // Light
      letterSpacing: -0.5, // tracking-tight
    ),

    // Standard List Items / Task Names (e.g., "Client alignment call")
    titleLarge: const TextStyle(
      fontFamily: geistFont,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),

    // Task descriptions
    titleMedium: const TextStyle(
      fontFamily: geistFont,
      fontSize: 16.0,
      fontWeight: FontWeight.w500, // Normal
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

    // Time blocks & Nav Items (e.g., "09:00 — 11:00 "Tasks")
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