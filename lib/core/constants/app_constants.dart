/// App Constants
///
/// LEARN: This file contains general constants used throughout the app.
/// Constants are values that never change during app execution.
///
/// Why use constants?
/// 1. Consistency - Same values everywhere
/// 2. Easy to update - Change once, updates everywhere
/// 3. Type safety - Compiler catches errors
/// 4. Performance - Compile-time constants are optimized
///
/// LEARN: In Dart, 'const' means the value is known at compile-time
/// and will never change. This is better for performance than variables.
library;

class AppConstants {
  // Private constructor prevents creating instances
  AppConstants._();

  // ============================================================================
  // SPACING & PADDING
  // ============================================================================

  /// Small spacing (4px)
  /// Use for: Tight spacing between related elements
  static const double spacingXS = 4.0;

  /// Small spacing (8px)
  /// Use for: Small gaps, icon padding
  static const double spacingS = 8.0;

  /// Medium spacing (16px)
  /// Use for: Standard gaps, card padding
  static const double spacingM = 16.0;

  /// Large spacing (24px)
  /// Use for: Section spacing, large gaps
  static const double spacingL = 24.0;

  /// Extra large spacing (32px)
  /// Use for: Major section separation
  static const double spacingXL = 32.0;

  /// Extra extra large spacing (48px)
  /// Use for: Screen-level spacing
  static const double spacingXXL = 48.0;

  // ============================================================================
  // BORDER RADIUS
  // ============================================================================

  /// Small border radius (4px)
  /// Use for: Small buttons, chips
  static const double radiusS = 4.0;

  /// Medium border radius (8px)
  /// Use for: Buttons, input fields, cards
  static const double radiusM = 8.0;

  /// Large border radius (12px)
  /// Use for: Large cards, dialogs
  static const double radiusL = 12.0;

  /// Extra large border radius (16px)
  /// Use for: Hero sections, large dialogs
  static const double radiusXL = 16.0;

  /// Circular border radius (50%)
  /// Use for: Avatar images, FAB buttons
  static const double radiusCircular = 50.0;

  // ============================================================================
  // ELEVATION (SHADOWS)
  // ============================================================================

  /// No elevation (flat)
  static const double elevationNone = 0.0;

  /// Small elevation (2px)
  /// Use for: Cards, buttons
  static const double elevationS = 2.0;

  /// Medium elevation (4px)
  /// Use for: Floating buttons, elevated cards
  static const double elevationM = 4.0;

  /// Large elevation (8px)
  /// Use for: Dialogs, bottom sheets
  static const double elevationL = 8.0;

  // ============================================================================
  // ICON SIZES
  // ============================================================================

  /// Small icon size (16px)
  static const double iconSizeS = 16.0;

  /// Medium icon size (24px) - Default
  static const double iconSizeM = 24.0;

  /// Large icon size (32px)
  static const double iconSizeL = 32.0;

  /// Extra large icon size (48px)
  static const double iconSizeXL = 48.0;

  // ============================================================================
  // ANIMATION DURATIONS
  // ============================================================================

  /// Very fast animation (100ms)
  static const Duration animationFast = Duration(milliseconds: 100);

  /// Normal animation (300ms) - Default
  static const Duration animationNormal = Duration(milliseconds: 300);

  /// Slow animation (500ms)
  static const Duration animationSlow = Duration(milliseconds: 500);

  /// Very slow animation (1000ms)
  static const Duration animationVerySlow = Duration(milliseconds: 1000);

  // ============================================================================
  // APP METADATA
  // ============================================================================

  /// App name
  static const String appName = 'Boos';

  /// App version (update this when releasing)
  static const String appVersion = '1.0.0';

  /// Minimum password length
  static const int minPasswordLength = 8;

  /// Maximum file upload size in MB
  static const int maxFileSizeMB = 10;

  /// Pagination - items per page
  static const int itemsPerPage = 20;

  // ============================================================================
  // VALIDATION CONSTANTS
  // ============================================================================

  /// Maximum characters for business name
  static const int maxBusinessNameLength = 100;

  /// Maximum characters for document title
  static const int maxDocumentTitleLength = 200;

  /// Maximum characters for description
  static const int maxDescriptionLength = 1000;
}
