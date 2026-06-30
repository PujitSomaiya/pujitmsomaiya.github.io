import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized typography system for the application (Lumina Engineering Portfolio).
///
/// Headings, Body, Buttons, Nav: Plus Jakarta Sans
/// Technical tags / Code elements: Geist / JetBrains Mono (Fallback)
class AppTextStyles {
  AppTextStyles._();

  /// Plus Jakarta Sans, extra bold, large size (48 sp, height 1.1)
  /// Used for: Hero Name
  static TextStyle get heroTitle => GoogleFonts.plusJakartaSans(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.02,
      );

  /// Plus Jakarta Sans, medium (22 sp)
  /// Used for: Hero Subtitle / Role
  static TextStyle get heroSubtitle => GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      );

  /// Plus Jakarta Sans, bold (32 sp)
  /// Used for: Section Title
  static TextStyle get sectionTitle => GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

  /// Plus Jakarta Sans, regular (16 sp)
  /// Used for: Section Subtitle
  static TextStyle get sectionSubtitle => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  /// Plus Jakarta Sans, semi-bold (20 sp)
  /// Used for: Project Card Titles
  static TextStyle get cardTitle => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  /// Plus Jakarta Sans, regular (14 sp, height: 1.6)
  /// Used for: Card Descriptions
  static TextStyle get cardDescription => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.6,
      );

  /// Plus Jakarta Sans, regular (18 sp, height: 1.6)
  /// Used for: Large Body Text
  static TextStyle get bodyLarge => GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        height: 1.6,
      );

  /// Plus Jakarta Sans, regular (16 sp, height: 1.6)
  /// Used for: Medium Body / Description Text
  static TextStyle get bodyMedium => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.6,
      );

  /// Plus Jakarta Sans, regular (12 sp)
  /// Used for: Small Body / Copyright / Secondary Text
  static TextStyle get bodySmall => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );

  /// Plus Jakarta Sans, semi-bold (14 sp)
  /// Used for: Button Labels
  static TextStyle get buttonText => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  /// Plus Jakarta Sans, medium (14 sp)
  /// Used for: Sticky Navigation Text
  static TextStyle get navText => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  /// Geist Mono / JetBrains Mono (fallback), medium (14 sp, letterSpacing: 0.05)
  /// Used for: Skill chips, tech badges, package names
  static TextStyle get chipText => GoogleFonts.jetBrainsMono(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.05,
      );

  /// Plus Jakarta Sans, regular (12 sp)
  /// Used for: Footer Copyright
  static TextStyle get footerText => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );
}
