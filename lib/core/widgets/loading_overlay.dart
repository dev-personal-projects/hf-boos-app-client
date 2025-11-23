import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

/// Loading Overlay Widget
///
/// LEARN: This widget shows a full-screen loading indicator.
/// It's useful when you need to block user interaction during async operations.
///
/// Why use an overlay?
/// 1. Prevents user interaction during loading
/// 2. Clear visual feedback
/// 3. Professional appearance
/// 4. Reusable across the app
///
/// LEARN: This widget uses a Stack to overlay the loading indicator
/// on top of existing content.

class LoadingOverlay extends StatelessWidget {
  /// Whether to show the loading indicator
  final bool isLoading;

  /// Child widget (content behind the overlay)
  final Widget child;

  /// Loading message (optional)
  final String? message;

  /// Opacity of the overlay background (0.0 to 1.0)
  final double opacity;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message = 'Loading...',
    this.opacity = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    // LEARN: Stack allows us to layer widgets on top of each other.
    // The child is the base layer, loading indicator is on top.
    return Stack(
      children: [
        // Base content
        child,

        // Loading overlay (only shown when isLoading is true)
        if (isLoading) _buildLoadingOverlay(context),
      ],
    );
  }

  /// Build the loading overlay
  ///
  /// LEARN: This creates a semi-transparent background with
  /// a loading indicator in the center.
  Widget _buildLoadingOverlay(BuildContext context) {
    return Container(
      // LEARN: Colors.black.withValues() creates a semi-transparent black.
      // This darkens the background while loading.
      color: Colors.black.withValues(alpha: opacity),
      child: Center(child: _buildLoadingContent(context)),
    );
  }

  /// Build loading content (spinner + message)
  Widget _buildLoadingContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(AppConstants.spacingL),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Loading spinner
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark
                    ? AppColors.primaryGreenDark
                    : AppColors.primaryGreenLight,
              ),
            ),
          ),

          // Loading message (if provided)
          if (message != null) ...[
            const SizedBox(height: AppConstants.spacingM),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Loading Overlay Helper
///
/// LEARN: This is a helper class that makes it easy to show/hide
/// loading overlays programmatically.
///
/// Usage:
/// ```dart
/// LoadingOverlayHelper.show(context, message: 'Loading...');
/// // ... do async work ...
/// LoadingOverlayHelper.hide(context);
/// ```

class LoadingOverlayHelper {
  /// Show loading overlay
  ///
  /// LEARN: This shows a loading overlay on top of the current screen.
  /// It returns a function to hide it.
  ///
  /// Parameters:
  /// - context: BuildContext
  /// - message: Optional loading message
  ///
  /// Returns: Function to hide the overlay
  static VoidCallback show(BuildContext context, {String? message}) {
    // LEARN: showDialog shows a modal dialog.
    // We use it to show the loading overlay.
    showDialog(
      context: context,
      barrierDismissible: false, // Can't dismiss by tapping outside
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => _LoadingDialog(message: message),
    );

    // Return function to hide
    return () => Navigator.of(context).pop();
  }

  /// Hide loading overlay
  ///
  /// LEARN: This hides the currently shown loading overlay.
  ///
  /// Parameters:
  /// - context: BuildContext
  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

/// Loading Dialog (internal use)
///
/// LEARN: This is the actual dialog widget shown by LoadingOverlayHelper.
/// It's private (starts with _) so it can't be used directly.
class _LoadingDialog extends StatelessWidget {
  final String? message;

  const _LoadingDialog({this.message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(AppConstants.spacingL),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDark
                      ? AppColors.primaryGreenDark
                      : AppColors.primaryGreenLight,
                ),
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: AppConstants.spacingM),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
