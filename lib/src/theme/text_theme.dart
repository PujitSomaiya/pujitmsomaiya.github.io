import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the full Material 3 typescale for the application.
///
/// Prefer accessing styles through [BuildContext] extensions:
/// ```dart
/// Text('Hello', style: context.textTheme.titleLarge);
/// ```
TextTheme buildTextTheme() {
  // Base TextTheme using Plus Jakarta Sans for all standard body and label roles
  final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(
    const TextTheme(
      // ── Body ──────────────────────────────────────────────────────────────────
      // Use for reading/content text. Optimised for legibility at comfortable
      // reading sizes. Default for paragraphs and descriptions.

      /// 16 sp — Primary body text.
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),

      /// 14 sp — Standard body text (most common).
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),

      /// 12 sp — Small body / caption text.
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),

      // ── Label ─────────────────────────────────────────────────────────────────
      // Use for UI control labels, buttons, and navigation items.

      /// 14 sp — Button and prominent control label.
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),

      /// 12 sp — Standard control label.
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),

      /// 11 sp — Smallest control label.
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    ),
  );

  // Return the theme customized with Plus Jakarta Sans Display, Headline, and Title styles
  return baseTextTheme.copyWith(
    // ── Display ──────────────────────────────────────────────────────────────
    // Use for the largest, most impactful text on a screen.

    /// 57 sp — Largest display text.
    displayLarge: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.displayLarge?.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.25,
      ) ?? const TextStyle(fontSize: 57, fontWeight: FontWeight.w800, letterSpacing: -0.25),
    ),

    /// 45 sp — Mid-size display text.
    displayMedium: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.displayMedium?.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ) ?? const TextStyle(fontSize: 45, fontWeight: FontWeight.w800, letterSpacing: 0),
    ),

    /// 36 sp — Smallest display text.
    displaySmall: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.displaySmall?.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ) ?? const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: 0),
    ),

    // ── Headline ─────────────────────────────────────────────────────────────
    // Use for page/screen-level headings.

    /// 32 sp — Large page-level heading.
    headlineLarge: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.headlineLarge?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ) ?? const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: 0),
    ),

    /// 28 sp — Standard page-level heading.
    headlineMedium: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.headlineMedium?.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ) ?? const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: 0),
    ),

    /// 24 sp — Compact page-level heading.
    headlineSmall: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.headlineSmall?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ) ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 0),
    ),

    // ── Title ─────────────────────────────────────────────────────────────────
    // Use for component-level titles and prominent labels inside cards/lists.

    /// 22 sp — Prominent component title.
    titleLarge: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.titleLarge?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ) ?? const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: 0),
    ),

    /// 16 sp — Standard component title.
    titleMedium: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ) ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15),
    ),

    /// 14 sp — Compact component title.
    titleSmall: GoogleFonts.plusJakartaSans(
      textStyle: baseTextTheme.titleSmall?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ) ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1),
    ),
  );
}