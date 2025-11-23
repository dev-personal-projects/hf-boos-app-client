/// Asset Constants
///
/// LEARN: This file contains paths to all assets (images, icons, logos) in the app.
/// Using constants for asset paths:
/// 1. Prevents typos (compiler catches errors)
/// 2. Easy refactoring (change path once)
/// 3. Autocomplete support in IDE
/// 4. Type safety
///
/// LEARN: Asset paths in Flutter are relative to the 'assets' folder
/// defined in pubspec.yaml. Example: 'assets/images/logo.png'
///
/// IMPORTANT: Make sure all assets are declared in pubspec.yaml!
library;

class AssetConstants {
  // Private constructor prevents creating instances
  AssetConstants._();

  // ============================================================================
  // BASE PATHS
  // ============================================================================

  /// Base path for images
  static const String imagesPath = 'assets/images';

  /// Base path for icons
  static const String iconsPath = 'assets/icons';

  /// Base path for logos
  static const String logoPath = 'assets/logo';

  // ============================================================================
  // LOGOS
  // ============================================================================

  /// Main app logo
  /// Use for: Splash screen, app bar, about page
  static const String logo = '$logoPath/logo.png';

  /// App logo (light mode variant)
  /// Use when: App is in light mode
  static const String logoLight = '$logoPath/logo_light.png';

  /// App logo (dark mode variant)
  /// Use when: App is in dark mode
  static const String logoDark = '$logoPath/logo_dark.png';

  /// App icon (for app launcher)
  /// Use for: Android/iOS app icon
  static const String appIcon = '$logoPath/app_icon.png';

  /// Splash screen logo
  /// Use for: Splash screen animation
  static const String splashLogo = '$logoPath/splash_logo.png';

  // ============================================================================
  // IMAGES
  // ============================================================================

  /// Placeholder image for empty states
  /// Use for: Empty lists, no data screens
  static const String placeholderImage = '$imagesPath/placeholder.png';

  /// Error image
  /// Use for: Error states, failed loads
  static const String errorImage = '$imagesPath/error.png';

  /// Success image
  /// Use for: Success states, confirmations
  static const String successImage = '$imagesPath/success.png';

  /// Onboarding image 1
  /// Use for: First onboarding screen
  static const String onboarding1 = '$imagesPath/onboarding_1.png';

  /// Onboarding image 2
  /// Use for: Second onboarding screen
  static const String onboarding2 = '$imagesPath/onboarding_2.png';

  /// Onboarding image 3
  /// Use for: Third onboarding screen
  static const String onboarding3 = '$imagesPath/onboarding_3.png';

  // ============================================================================
  // ICONS
  // ============================================================================

  /// Document icon
  /// Use for: Document-related features
  static const String iconDocument = '$iconsPath/document.png';

  /// Invoice icon
  /// Use for: Invoice features
  static const String iconInvoice = '$iconsPath/invoice.png';

  /// Receipt icon
  /// Use for: Receipt features
  static const String iconReceipt = '$iconsPath/receipt.png';

  /// Quotation icon
  /// Use for: Quotation features
  static const String iconQuotation = '$iconsPath/quotation.png';

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Get logo based on theme brightness
  ///
  /// LEARN: This is a helper method that returns the appropriate logo
  /// based on whether the app is in light or dark mode.
  ///
  /// Parameters:
  /// - isDark: true if dark mode, false if light mode
  ///
  /// Returns: Path to the appropriate logo
  static String getLogoForTheme(bool isDark) {
    return isDark ? logoDark : logoLight;
  }
}
