import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the full Material 3 typescale for the application.
///
/// Prefer accessing styles through [BuildContext] extensions:
/// ```dart
/// Text('Hello', style: context.textTheme.titleLarge);
/// ```
TextTheme buildTextTheme() {
  final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(
    const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.6,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.6,
      ),
    ),
  );

  return baseTextTheme.copyWith(
    displayLarge: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.displayLarge?.copyWith(
        fontSize: 64,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.04,
        height: 1.1,
      ),
    ),
    displayMedium: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.displayMedium?.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.02,
        height: 1.2,
      ),
    ),
    displaySmall: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.displaySmall?.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
        height: 1.2,
      ),
    ),
    headlineLarge: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.headlineLarge?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 1.2,
      ),
    ),
    headlineMedium: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.headlineMedium?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 1.3,
      ),
    ),
    headlineSmall: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.headlineSmall?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 1.4,
      ),
    ),
    titleLarge: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.4,
      ),
    ),
    titleMedium: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.4,
      ),
    ),
    titleSmall: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.titleSmall?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.4,
      ),
    ),
    labelLarge: GoogleFonts.jetBrainsMono(
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.1,
        height: 1,
      ),
    ),
    labelMedium: GoogleFonts.jetBrainsMono(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.02,
        height: 1.5,
      ),
    ),
    labelSmall: GoogleFonts.jetBrainsMono(
      textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.05,
        height: 1,
      ),
    ),
  );
}