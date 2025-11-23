import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// AppTheme
///
/// This class creates complete ThemeData objects for light and dark modes.
/// ThemeData is Flutter's way of defining the entire visual configuration
/// of your app (colors, fonts, shapes, etc.)
///
/// By setting this up properly, you get:
/// 1. Automatic theme switching (light/dark)
/// 2. Consistent styling across all widgets
/// 3. Easy maintenance (change one value, entire app updates)
class AppTheme {
  AppTheme._();

  // ============================================================================
  // LIGHT THEME
  // ============================================================================

  static ThemeData get lightTheme {
    return ThemeData(
      // --------------------------------------------------------------------------
      // GENERAL CONFIGURATION
      // --------------------------------------------------------------------------

      /// useMaterial3: Enables Material Design 3 (latest design system)
      /// Material 3 has rounder corners, better accessibility, updated components
      useMaterial3: true,

      /// brightness: Tells Flutter this is a light theme
      /// This affects default icon colors, status bar, etc.
      brightness: Brightness.light,

      // --------------------------------------------------------------------------
      // COLOR SCHEME - Defines all semantic colors for Material widgets
      // --------------------------------------------------------------------------
      colorScheme: ColorScheme.light(
        /// primary: Main brand color (buttons, FAB, app bar)
        primary: AppColors.primaryGreenLight,

        /// onPrimary: Text/icon color on primary colored backgrounds
        onPrimary: Colors.white,

        /// secondary: Secondary actions and accents
        secondary: AppColors.secondaryGreenLight,

        /// onSecondary: Text/icon color on secondary colored backgrounds
        onSecondary: Colors.white,

        /// surface: Background color of cards, dialogs, sheets
        surface: AppColors.surfaceLight,

        /// onSurface: Text/icon color on surface backgrounds
        onSurface: AppColors.textPrimaryLight,

        /// error: Color for errors and destructive actions
        error: AppColors.error,

        /// onError: Text/icon color on error colored backgrounds
        onError: Colors.white,

        /// Outline: Border colors for outlined buttons, text fields
        outline: AppColors.borderLight,
      ),

      // --------------------------------------------------------------------------
      // SCAFFOLD BACKGROUND - Default background for Scaffold widgets
      // --------------------------------------------------------------------------
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // --------------------------------------------------------------------------
      // APP BAR THEME - Styling for all AppBars in the app
      // --------------------------------------------------------------------------
      appBarTheme: AppBarTheme(
        /// backgroundColor: App bar background color
        backgroundColor: AppColors.primaryGreenLight,

        /// foregroundColor: Text and icon color in app bar
        foregroundColor: Colors.white,

        /// elevation: Shadow depth (0 = flat, higher = more shadow)
        elevation: 0,

        /// centerTitle: Whether title is centered (common on iOS)
        centerTitle: false,

        /// titleTextStyle: Custom text style for app bar title
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.15,
        ),

        /// systemOverlayStyle: Changes status bar color/icons
        /// This makes status bar icons white on green background
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // --------------------------------------------------------------------------
      // CARD THEME - Styling for Card widgets
      // --------------------------------------------------------------------------
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 2, // Slight shadow for depth
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // --------------------------------------------------------------------------
      // ELEVATED BUTTON THEME - Primary action buttons
      // --------------------------------------------------------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          /// backgroundColor: Button background color
          backgroundColor: AppColors.primaryGreenLight,

          /// foregroundColor: Text/icon color on button
          foregroundColor: Colors.white,

          /// elevation: Button shadow depth
          elevation: 2,

          /// padding: Internal spacing
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),

          /// shape: Button shape with rounded corners
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

          /// textStyle: Text style for button text
          textStyle: AppTextStyles.buttonText,

          /// minimumSize: Ensure buttons have minimum height for touch targets
          minimumSize: Size(88, 48),
        ),
      ),

      // --------------------------------------------------------------------------
      // OUTLINED BUTTON THEME - Secondary action buttons
      // --------------------------------------------------------------------------
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGreenLight,
          side: BorderSide(color: AppColors.primaryGreenLight, width: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTextStyles.buttonText,
          minimumSize: Size(88, 48),
        ),
      ),

      // --------------------------------------------------------------------------
      // TEXT BUTTON THEME - Tertiary actions (e.g., "Cancel", "Skip")
      // --------------------------------------------------------------------------
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGreenLight,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTextStyles.buttonText,
        ),
      ),

      // --------------------------------------------------------------------------
      // INPUT DECORATION THEME - Text fields styling
      // --------------------------------------------------------------------------
      inputDecorationTheme: InputDecorationTheme(
        /// filled: Whether text field has background color
        filled: true,

        /// fillColor: Background color of text field
        fillColor: AppColors.surfaceLight,

        /// contentPadding: Internal spacing of text field
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        /// border: Default border style
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.borderLight, width: 1),
        ),

        /// enabledBorder: Border when field is not focused
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.borderLight, width: 1),
        ),

        /// focusedBorder: Border when field is focused
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primaryGreenLight,
            width: 2, // Thicker when focused
          ),
        ),

        /// errorBorder: Border when field has error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error, width: 1),
        ),

        /// focusedErrorBorder: Border when field has error AND is focused
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),

        /// labelStyle: Style for floating label
        labelStyle: TextStyle(
          color: AppColors.textSecondaryLight,
          fontSize: 16,
        ),

        /// hintStyle: Style for hint text
        hintStyle: TextStyle(color: AppColors.textSecondaryLight, fontSize: 14),

        /// errorStyle: Style for error text below field
        errorStyle: AppTextStyles.errorText,
      ),

      // --------------------------------------------------------------------------
      // FLOATING ACTION BUTTON THEME - The circular button for main actions
      // --------------------------------------------------------------------------
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGreenLight,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // --------------------------------------------------------------------------
      // BOTTOM NAVIGATION BAR THEME
      // --------------------------------------------------------------------------
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.primaryGreenLight,
        unselectedItemColor: AppColors.textSecondaryLight,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedIconTheme: IconThemeData(size: 24),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        type: BottomNavigationBarType.fixed, // Fixed = all items visible
        elevation: 8,
      ),

      // --------------------------------------------------------------------------
      // DIVIDER THEME - Horizontal lines
      // --------------------------------------------------------------------------
      dividerTheme: DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1,
        space: 1,
      ),

      // --------------------------------------------------------------------------
      // TEXT THEME - Apply our custom text styles
      // --------------------------------------------------------------------------
      textTheme: AppTextStyles.lightTextTheme,

      // --------------------------------------------------------------------------
      // ICON THEME - Default icon styling
      // --------------------------------------------------------------------------
      iconTheme: IconThemeData(color: AppColors.textPrimaryLight, size: 24),
    );
  }

  // ============================================================================
  // DARK THEME
  // ============================================================================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryGreenDark,
        onPrimary: Colors.white,
        secondary: AppColors.secondaryGreenDark,
        onSecondary: Colors.white,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        error: AppColors.error,
        onError: Colors.white,
        outline: AppColors.borderDark,
      ),

      scaffoldBackgroundColor: AppColors.backgroundDark,

      appBarTheme: AppBarTheme(
        /// backgroundColor: App bar uses green in dark mode for brand consistency
        backgroundColor: AppColors.primaryGreenDark,

        /// foregroundColor: White text/icons for good contrast on green
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.15,
        ),

        /// systemOverlayStyle: Light icons on green background
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreenDark,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTextStyles.buttonText,
          minimumSize: Size(88, 48),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGreenDark,
          side: BorderSide(color: AppColors.primaryGreenDark, width: 1.5),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTextStyles.buttonText,
          minimumSize: Size(88, 48),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGreenDark,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTextStyles.buttonText,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.borderDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.borderDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primaryGreenDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: TextStyle(color: AppColors.textSecondaryDark, fontSize: 16),
        hintStyle: TextStyle(color: AppColors.textSecondaryDark, fontSize: 14),
        errorStyle: AppTextStyles.errorText,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGreenDark,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primaryGreenDark,
        unselectedItemColor: AppColors.textSecondaryDark,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedIconTheme: IconThemeData(size: 24),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      dividerTheme: DividerThemeData(
        color: AppColors.borderDark,
        thickness: 1,
        space: 1,
      ),

      textTheme: AppTextStyles.darkTextTheme,

      iconTheme: IconThemeData(color: AppColors.textPrimaryDark, size: 24),
    );
  }
}
