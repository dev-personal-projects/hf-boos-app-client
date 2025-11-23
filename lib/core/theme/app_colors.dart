import 'package:flutter/material.dart';

/// AppColors
///
/// This class holds all color constants used throughout the app.
/// By centralizing colors here, we can:
/// 1. Maintain consistency across the app
/// 2. Easily switch between light/dark mode
/// 3. Update colors in one place instead of searching everywhere
///
/// We use static const to make colors compile-time constants (better performance)
class AppColors {
  // Private constructor to prevent instantiation
  // This class should only be used for accessing static constants
  AppColors._();

  // ============================================================================
  // PRIMARY COLORS - Main brand colors (Green theme)
  // ============================================================================

  /// Primary green - Used for main actions, app bar, FAB
  /// Light mode: Emerald green (like M-Pesa)
  static const Color primaryGreenLight = Color(0xFF00A86B);

  /// Primary green for dark mode - Brighter so it stands out on dark backgrounds
  static const Color primaryGreenDark = Color(0xFF10B981);

  /// Secondary green - Used for secondary buttons, less important actions
  static const Color secondaryGreenLight = Color(0xFF008055);
  static const Color secondaryGreenDark = Color(0xFF059669);

  // ============================================================================
  // ACCENT COLORS - For highlights, warnings, CTAs
  // ============================================================================

  /// Orange accent - Used for important actions, warnings, highlights
  /// Examples: Delete button, important badges, promotional banners
  static const Color accentOrangeLight = Color(0xFFF97316);
  static const Color accentOrangeDark = Color(0xFFFB923C);

  // ============================================================================
  // BACKGROUND COLORS - Main screen backgrounds
  // ============================================================================

  /// Light mode background - Slightly off-white for reduced eye strain
  static const Color backgroundLight = Color(0xFFFAFAFA);

  /// Dark mode background - Very dark blue-gray (softer than pure black)
  static const Color backgroundDark = Color(0xFF0F172A);

  // ============================================================================
  // SURFACE COLORS - Cards, dialogs, elevated components
  // ============================================================================

  /// Light mode surface - Pure white for cards and elevated components
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// Dark mode surface - Lighter than background but still dark
  static const Color surfaceDark = Color(0xFF1E293B);

  // ============================================================================
  // TEXT COLORS - For readability
  // ============================================================================

  /// Primary text color for light mode - Dark gray (not pure black for softer look)
  static const Color textPrimaryLight = Color(0xFF1F2937);

  /// Secondary text color for light mode - Medium gray for less important text
  static const Color textSecondaryLight = Color(0xFF6B7280);

  /// Primary text color for dark mode - Off-white (not pure white for softer look)
  static const Color textPrimaryDark = Color(0xFFF1F5F9);

  /// Secondary text color for dark mode - Light gray for less important text
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // ============================================================================
  // SEMANTIC COLORS - Universal meaning (don't change between themes)
  // ============================================================================

  /// Success color - Green for successful operations
  /// Example: "Invoice created successfully"
  static const Color success = Color(0xFF10B981);

  /// Error color - Red for errors and destructive actions
  /// Example: "Login failed", "Delete invoice"
  static const Color error = Color(0xFFEF4444);

  /// Warning color - Yellow/Orange for warnings
  /// Example: "Draft not saved", "Low balance"
  static const Color warning = Color(0xFFF59E0B);

  /// Info color - Blue for informational messages
  /// Example: "New feature available", "Update recommended"
  static const Color info = Color(0xFF3B82F6);

  // ============================================================================
  // BORDER COLORS - For input fields, dividers, etc.
  // ============================================================================

  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);

  // ============================================================================
  // DISABLED COLORS - For inactive buttons, fields
  // ============================================================================

  static const Color disabledLight = Color(0xFFD1D5DB);
  static const Color disabledDark = Color(0xFF4B5563);

  // ============================================================================
  // GRADIENT COLORS - For fancy backgrounds
  // ============================================================================

  /// Gradient for app bar or hero sections in light mode
  static const LinearGradient primaryGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGreenLight, secondaryGreenLight],
  );

  /// Gradient for app bar or hero sections in dark mode
  static const LinearGradient primaryGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGreenDark, secondaryGreenDark],
  );
}
