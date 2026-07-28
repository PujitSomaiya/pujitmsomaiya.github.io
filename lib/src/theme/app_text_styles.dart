import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized typography system for the application (Lumina Engineering Portfolio).
///
/// Headings, Body, Buttons, Nav: Plus Jakarta Sans
/// Technical tags / Code elements: Geist / JetBrains Mono (Fallback)
class AppTextStyles {
  AppTextStyles._();

  /// Plus Jakarta Sans, extra bold, display-hero (64 sp, height 1.1, letterSpacing: -0.04)
  /// Used for: Hero Name
  static TextStyle get heroTitle => GoogleFonts.plusJakartaSans(
        fontSize: 64,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.04,
      );

  /// Plus Jakarta Sans, medium (16 sp, height 1.6)
  /// Used for: Hero Subtitle / Role
  static TextStyle get heroSubtitle => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  /// Plus Jakarta Sans, bold, headline-lg (32 sp, height 1.2)
  /// Used for: Section Title
  static TextStyle get sectionTitle => GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
      );

  /// Plus Jakarta Sans, regular (16 sp, height 1.6)
  /// Used for: Section Subtitle
  static TextStyle get sectionSubtitle => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  /// Plus Jakarta Sans, semi-bold, headline-md (20 sp, height 1.4)
  /// Used for: Project Card Titles
  static TextStyle get cardTitle => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  /// Plus Jakarta Sans, regular, body-base (16 sp, height: 1.6)
  /// Used for: Card Descriptions
  static TextStyle get cardDescription => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  /// Plus Jakarta Sans, regular, body-base (16 sp, height: 1.6)
  /// Used for: Large Body Text
  static TextStyle get bodyLarge => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  /// Plus Jakarta Sans, regular, body-base (16 sp, height: 1.6)
  /// Used for: Medium Body / Description Text
  static TextStyle get bodyMedium => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  /// JetBrains Mono, bold, status-sm (10 sp, height 1.0, letterSpacing: 0.05)
  /// Used for: Small Body / Copyright / Secondary Text
  static TextStyle get bodySmall => GoogleFonts.jetBrainsMono(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: 0.05,
      );

  /// JetBrains Mono, bold, label-caps (12 sp, height 1.0, letterSpacing: 0.1)
  /// Used for: Button Labels
  static TextStyle get buttonText => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: 0.1,
      );

  /// JetBrains Mono, bold, label-caps (12 sp, height 1.0, letterSpacing: 0.1)
  /// Used for: Sticky Navigation Text
  static TextStyle get navText => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: 0.1,
      );

  /// JetBrains Mono, medium, data-mono (14 sp, height 1.5, letterSpacing: 0.02)
  /// Used for: Skill chips, tech badges, package names
  static TextStyle get chipText => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
        letterSpacing: 0.02,
      );

  /// JetBrains Mono, bold, status-sm (10 sp, height 1.0, letterSpacing: 0.05)
  /// Used for: Footer Copyright
  static TextStyle get footerText => GoogleFonts.jetBrainsMono(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: 0.05,
      );

}
