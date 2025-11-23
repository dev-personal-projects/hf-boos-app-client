import 'package:flutter/material.dart';
import 'app_colors.dart';

/// AppTextStyles
///
/// Defines all text styles used in the app for consistency.
/// Flutter uses a type scale system based on Material Design:
/// - Display: Very large text (rarely used)
/// - Headline: Section headers, titles
/// - Title: Card titles, dialog titles
/// - Body: Regular paragraph text
/// - Label: Button text, small labels
///
/// We create separate styles for light and dark mode because
/// text color needs to change based on background.
class AppTextStyles {
  AppTextStyles._();

  // ============================================================================
  // LIGHT MODE TEXT STYLES
  // ============================================================================

  /// Creates the complete text theme for light mode
  /// TextTheme is a Flutter class that holds all text style variants
  static TextTheme lightTextTheme = TextTheme(
    // --------------------------------------------------------------------------
    // DISPLAY STYLES - Largest text (used sparingly)
    // --------------------------------------------------------------------------
    displayLarge: TextStyle(
      fontSize: 57, // Very large
      fontWeight: FontWeight.w400, // Regular weight
      color: AppColors.textPrimaryLight,
      letterSpacing: -0.25, // Slight tightening for large text
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
    ),

    // --------------------------------------------------------------------------
    // HEADLINE STYLES - Page titles, section headers
    // --------------------------------------------------------------------------
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600, // Semi-bold for emphasis
      color: AppColors.textPrimaryLight,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),

    // --------------------------------------------------------------------------
    // TITLE STYLES - Card headers, dialog titles, list tile titles
    // --------------------------------------------------------------------------
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500, // Medium weight
      color: AppColors.textPrimaryLight,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.1,
    ),

    // --------------------------------------------------------------------------
    // BODY STYLES - Regular paragraph text, main content
    // --------------------------------------------------------------------------
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400, // Regular weight
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryLight, // Secondary color for less emphasis
      letterSpacing: 0.4,
    ),

    // --------------------------------------------------------------------------
    // LABEL STYLES - Buttons, tabs, small labels
    // --------------------------------------------------------------------------
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryLight,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryLight,
      letterSpacing: 0.5,
    ),
  );

  // ============================================================================
  // DARK MODE TEXT STYLES
  // ============================================================================

  /// Creates the complete text theme for dark mode
  /// Same structure as light mode, but with different colors
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark, // Light text on dark background
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
    ),

    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),

    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.1,
    ),

    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryDark,
      letterSpacing: 0.4,
    ),

    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimaryDark,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryDark,
      letterSpacing: 0.5,
    ),
  );

  // ============================================================================
  // CUSTOM TEXT STYLES - For specific use cases
  // ============================================================================

  /// Style for currency amounts (e.g., "KES 1,234.56")
  /// Bold and green to draw attention
  static TextStyle currencyLight = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.primaryGreenLight,
    letterSpacing: 0.5,
  );

  static TextStyle currencyDark = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryGreenDark,
    letterSpacing: 0.5,
  );

  /// Style for button text - all caps and medium weight
  static TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25, // Wide spacing for readability
    color: Colors.white, // Buttons usually have colored backgrounds
  );

  /// Style for error messages
  static TextStyle errorText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
    letterSpacing: 0.4,
  );
}
