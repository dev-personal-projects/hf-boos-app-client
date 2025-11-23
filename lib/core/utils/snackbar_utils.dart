import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Snackbar Utilities
///
/// LEARN: This file provides helper functions to show snackbars.
/// Snackbars are temporary messages that appear at the bottom of the screen.
///
/// Why use snackbars?
/// 1. User feedback - Show success/error messages
/// 2. Non-intrusive - Don't block the UI
/// 3. Consistent styling - Same look everywhere
/// 4. Easy to use - One function call
///
/// LEARN: Snackbars are shown using ScaffoldMessenger.
/// They automatically disappear after a few seconds.

class SnackbarUtils {
  // Private constructor prevents creating instances
  SnackbarUtils._();

  // ============================================================================
  // SUCCESS SNACKBAR
  // ============================================================================

  /// Show success snackbar
  ///
  /// LEARN: Success snackbars are green and show positive feedback.
  /// Use for: Successful operations, confirmations, etc.
  ///
  /// Example:
  /// SnackbarUtils.showSuccess(context, 'Document created successfully!');
  ///
  /// Parameters:
  /// - context: BuildContext (needed to show snackbar)
  /// - message: The message to display
  /// - duration: How long to show (default: 3 seconds)
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: duration,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ============================================================================
  // ERROR SNACKBAR
  // ============================================================================

  /// Show error snackbar
  ///
  /// LEARN: Error snackbars are red and show error messages.
  /// Use for: Failed operations, validation errors, etc.
  ///
  /// Example:
  /// SnackbarUtils.showError(context, 'Failed to load documents');
  ///
  /// Parameters:
  /// - context: BuildContext
  /// - message: The error message to display
  /// - duration: How long to show (default: 4 seconds - longer for errors)
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: duration,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ============================================================================
  // WARNING SNACKBAR
  // ============================================================================

  /// Show warning snackbar
  ///
  /// LEARN: Warning snackbars are orange/yellow and show warnings.
  /// Use for: Warnings, important notices, etc.
  ///
  /// Example:
  /// SnackbarUtils.showWarning(context, 'Please save your work');
  ///
  /// Parameters:
  /// - context: BuildContext
  /// - message: The warning message to display
  /// - duration: How long to show (default: 3 seconds)
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.warning,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: duration,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ============================================================================
  // INFO SNACKBAR
  // ============================================================================

  /// Show info snackbar
  ///
  /// LEARN: Info snackbars are blue and show informational messages.
  /// Use for: General information, tips, etc.
  ///
  /// Example:
  /// SnackbarUtils.showInfo(context, 'New feature available!');
  ///
  /// Parameters:
  /// - context: BuildContext
  /// - message: The info message to display
  /// - duration: How long to show (default: 3 seconds)
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: duration,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ============================================================================
  // CUSTOM SNACKBAR
  // ============================================================================

  /// Show custom snackbar
  ///
  /// LEARN: For when you need a custom snackbar with different styling.
  /// Use this when the standard snackbars don't fit your needs.
  ///
  /// Parameters:
  /// - context: BuildContext
  /// - message: The message to display
  /// - backgroundColor: Custom background color
  /// - icon: Custom icon (optional)
  /// - duration: How long to show
  static void showCustom(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: duration,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Hide current snackbar
  ///
  /// LEARN: Sometimes you want to hide a snackbar programmatically.
  /// Use this to dismiss the current snackbar.
  ///
  /// Parameters:
  /// - context: BuildContext
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
