import 'package:flutter/material.dart';

class MyTheme {
  static const String geistFont = 'Geist';
  static const String interFont = geistFont; // alias kept for existing widgets

  // ── Primary (Electric Indigo) ─────────────────────────────────────────
  static const Color primaryColor          = Color(0xFF4648D4);
  static const Color primaryContainerColor = Color(0xFF6063EE);
  static const Color inversePrimaryColor   = Color(0xFFC0C1FF);
  static const Color onPrimaryColor        = Color(0xFFFFFFFF);
  static const Color onPrimaryContainerColor = Color(0xFFFFFBFF);

  // ── Secondary (Electric Cyan) ─────────────────────────────────────────
  static const Color secondaryColor          = Color(0xFF00687A);
  static const Color secondaryContainerColor = Color(0xFF57DFFE);
  static const Color onSecondaryColor        = Color(0xFFFFFFFF);
  static const Color onSecondaryContainerColor = Color(0xFF006172);

  // ── Tertiary ──────────────────────────────────────────────────────────
  static const Color tertiaryColor          = Color(0xFF545B71);
  static const Color tertiaryContainerColor = Color(0xFF6D748B);
  static const Color onTertiaryColor        = Color(0xFFFFFFFF);
  static const Color onTertiaryContainerColor = Color(0xFFFEFCFF);

  // ── Error ─────────────────────────────────────────────────────────────
  static const Color errorColor          = Color(0xFFBA1A1A);
  static const Color errorContainerColor = Color(0xFFFFDAD6);
  static const Color onErrorColor        = Color(0xFFFFFFFF);
  static const Color onErrorContainerColor = Color(0xFF93000A);

  // ── Surface / Background ──────────────────────────────────────────────
  static const Color surfaceColor              = Color(0xFFFAF8FF);
  static const Color surfaceDimColor           = Color(0xFFD3D9F1);
  static const Color surfaceContainerLowest    = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow       = Color(0xFFF2F3FF);
  static const Color surfaceContainerColor     = Color(0xFFEAEDFF);
  static const Color surfaceContainerHigh      = Color(0xFFE2E7FF);
  static const Color surfaceContainerHighest   = Color(0xFFDCE2FA);
  static const Color surfaceVariantColor       = Color(0xFFDCE2FA);
  static const Color onSurfaceColor            = Color(0xFF141B2C);
  static const Color onSurfaceVariantColor     = Color(0xFF464554);
  static const Color inverseSurfaceColor       = Color(0xFF293042);
  static const Color inverseOnSurfaceColor     = Color(0xFFEEF0FF);
  static const Color outlineColor              = Color(0xFF767586);
  static const Color outlineVariantColor       = Color(0xFFC7C4D7);
  static const Color surfaceTintColor          = Color(0xFF494BD6);

  // ── Legacy alias kept for existing widgets ────────────────────────────
  static const Color neutralColor = onSurfaceColor;

  // ── Spacing tokens (4 px base unit) ──────────────────────────────────
  static const double spaceXs  = 4.0;
  static const double spaceSm  = 8.0;
  static const double spaceMd  = 16.0;
  static const double spaceLg  = 24.0;
  static const double spaceXl  = 40.0;
  static const double space2xl = 64.0;

  // ── Border-radius tokens ──────────────────────────────────────────────
  static const double radiusSm   = 4.0;   // rounded-sm
  static const double radiusMd   = 8.0;   // rounded (default, small interactives)
  static const double radiusLg   = 16.0;  // rounded-lg (cards)
  static const double radiusXl   = 24.0;  // rounded-xl (search bars / tags)
  static const double radiusFull = 9999.0;

  // ── Schedule palette (unchanged) ──────────────────────────────────────
  static const Color scheduleBg       = Color(0xFFF5F6FA);
  static const Color schedulePurple   = Color(0xFF7B6CF6);
  static const Color scheduleCardTint = Color(0xFFF7F6FF);
  static const Color scheduleFab      = Color(0xFF1E3A6E);

  // ── Auth / Sign-up palette (unchanged) ───────────────────────────────
  static const Color signUpBg            = Color(0xFFEBECF8);
  static const Color signUpTeal          = Color(0xFF0D7A7A);
  static const Color signUpGradientStart = Color(0xFF9477F5);
  static const Color signUpGradientEnd   = Color(0xFF5AD9F5);
  static const Color signUpFieldBorder   = Color(0xFFE4E7F2);
  static const Color signUpSubtitle      = Color(0xFF8892AB);

  // ── Color scheme ──────────────────────────────────────────────────────
  static final ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    primaryContainer: primaryContainerColor,
    onPrimaryContainer: onPrimaryContainerColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    secondaryContainer: secondaryContainerColor,
    onSecondaryContainer: onSecondaryContainerColor,
    tertiary: tertiaryColor,
    onTertiary: onTertiaryColor,
    tertiaryContainer: tertiaryContainerColor,
    onTertiaryContainer: onTertiaryContainerColor,
    error: errorColor,
    onError: onErrorColor,
    errorContainer: errorContainerColor,
    onErrorContainer: onErrorContainerColor,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
    onSurfaceVariant: onSurfaceVariantColor,
    outline: outlineColor,
    outlineVariant: outlineVariantColor,
    inverseSurface: inverseSurfaceColor,
    onInverseSurface: inverseOnSurfaceColor,
    inversePrimary: inversePrimaryColor,
    surfaceTint: surfaceTintColor,
  );

  // ── Text theme ────────────────────────────────────────────────────────
  //
  // Token → Flutter slot mapping:
  //   display-lg        → displayLarge   (48 / w600 / lh 1.1 / ls -0.04em)
  //   headline-lg       → headlineLarge  (32 / w500 / lh 1.2 / ls -0.02em)
  //   headline-lg-mobile→ headlineMedium (24 / w500 / lh 1.2 / ls -0.02em)  ← major page headers
  //   title-md          → titleLarge     (20 / w500 / lh 1.4 / ls -0.01em)  ← app-bar / names
  //   body-lg           → titleMedium    (16 / w400 / lh 1.6 / ls 0)        ← list items / tasks
  //   body-md           → bodyMedium     (14 / w400 / lh 1.5 / ls 0)        ← standard body
  //   label-sm          → labelLarge     (12 / w600 / lh 1.0 / ls 0.05em)   ← section headers
  //                      → labelMedium   (11 / w500 / lh 1.0 / ls 0.05em)   ← time / nav
  //                      → labelSmall    (10 / w700 / lh 1.0 / ls 0.05em)   ← tags / badges
  static final TextTheme textTheme = TextTheme(
    displayLarge: const TextStyle(
      fontFamily: geistFont,
      fontSize: 48.0,
      fontWeight: FontWeight.w600,
      height: 1.1,
      letterSpacing: -1.92, // -0.04em × 48
    ),
    headlineLarge: const TextStyle(
      fontFamily: geistFont,
      fontSize: 32.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
      letterSpacing: -0.64, // -0.02em × 32
    ),
    headlineMedium: const TextStyle(
      fontFamily: geistFont,
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
      letterSpacing: -0.48, // -0.02em × 24
    ),
    titleLarge: const TextStyle(
      fontFamily: geistFont,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      height: 1.4,
      letterSpacing: -0.2, // -0.01em × 20
    ),
    titleMedium: const TextStyle(
      fontFamily: geistFont,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.6,
      letterSpacing: 0.0,
    ),
    bodyMedium: const TextStyle(
      fontFamily: geistFont,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 0.0,
    ),
    labelLarge: const TextStyle(
      fontFamily: geistFont,
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      height: 1.0,
      letterSpacing: 0.6, // 0.05em × 12
    ),
    labelMedium: const TextStyle(
      fontFamily: geistFont,
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      height: 1.0,
      letterSpacing: 0.55, // 0.05em × 11
    ),
    labelSmall: const TextStyle(
      fontFamily: geistFont,
      fontSize: 10.0,
      fontWeight: FontWeight.w700,
      height: 1.0,
      letterSpacing: 0.5, // 0.05em × 10
    ),
  ).apply(
    bodyColor: onSurfaceColor,
    displayColor: onSurfaceColor,
  );

  // ── Theme data ────────────────────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    fontFamily: geistFont,
    colorScheme: lightScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: surfaceColor,
  );
}
