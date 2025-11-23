import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_constants.dart';

/// Custom Button Widget
///
/// LEARN: This is a reusable button widget that follows our app's design system.
/// It provides consistent styling across the app.
///
/// Why create custom widgets?
/// 1. Consistency - Same look everywhere
/// 2. Reusability - Write once, use many times
/// 3. Maintainability - Update styling in one place
/// 4. Type safety - Compile-time checks
///
/// LEARN: This widget wraps Flutter's built-in buttons but adds our custom styling.
/// It supports three variants: primary, secondary, and text.

class CustomButton extends StatelessWidget {
  /// Button text
  final String text;

  /// Button action (what happens when clicked)
  final VoidCallback? onPressed;

  /// Button variant
  ///
  /// LEARN: Enum-like class for button types.
  /// - primary: Main action (green background)
  /// - secondary: Secondary action (outlined)
  /// - text: Tertiary action (text only)
  final ButtonVariant variant;

  /// Show loading indicator
  ///
  /// LEARN: When true, shows a loading spinner instead of text.
  /// Use this when the button action is async (like API calls).
  final bool isLoading;

  /// Icon to show before text
  final IconData? icon;

  /// Button width (null = full width)
  final double? width;

  /// Button height
  final double? height;

  /// Custom text style
  final TextStyle? textStyle;

  /// Constructor
  ///
  /// LEARN: Required parameters must be provided.
  /// Optional parameters (with ?) can be omitted.
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // LEARN: We use a switch statement to return different button types
    // based on the variant. This is cleaner than if-else statements.
    switch (variant) {
      case ButtonVariant.primary:
        return _buildPrimaryButton(context);
      case ButtonVariant.secondary:
        return _buildSecondaryButton(context);
      case ButtonVariant.text:
        return _buildTextButton(context);
    }
  }

  /// Build primary button (green background)
  ///
  /// LEARN: Primary buttons are for main actions.
  /// They have a green background and white text.
  Widget _buildPrimaryButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.primaryGreenDark
        : AppColors.primaryGreenLight;

    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: AppConstants.elevationS,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  /// Build secondary button (outlined)
  ///
  /// LEARN: Secondary buttons are for less important actions.
  /// They have a green border and green text.
  Widget _buildSecondaryButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? AppColors.primaryGreenDark
        : AppColors.primaryGreenLight;

    return SizedBox(
      width: width,
      height: height ?? 48,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: borderColor,
          side: BorderSide(color: borderColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  /// Build text button
  ///
  /// LEARN: Text buttons are for tertiary actions (like "Cancel", "Skip").
  /// They have no background, just colored text.
  Widget _buildTextButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.primaryGreenDark
        : AppColors.primaryGreenLight;

    return SizedBox(
      width: width,
      height: height ?? 48,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.spacingM,
            vertical: AppConstants.spacingS,
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  /// Build button content (text, icon, loading indicator)
  ///
  /// LEARN: This method builds the content inside the button.
  /// It handles loading state, icons, and text.
  Widget _buildButtonContent() {
    if (isLoading) {
      // LEARN: CircularProgressIndicator shows a spinning loader.
      // We use SizedBox to control its size.
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == ButtonVariant.primary ? Colors.white : Colors.green,
          ),
        ),
      );
    }

    // LEARN: Row arranges widgets horizontally.
    // We use it to place icon and text side by side.
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppConstants.iconSizeM),
          const SizedBox(width: AppConstants.spacingS),
          Text(
            text,
            style:
                textStyle ??
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      );
    }

    return Text(
      text,
      style:
          textStyle ??
          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}

/// Button Variant Enum
///
/// LEARN: This is an enum-like class that defines button types.
/// Enums are useful when you have a fixed set of options.
enum ButtonVariant {
  /// Primary button (green background)
  primary,

  /// Secondary button (outlined)
  secondary,

  /// Text button (no background)
  text,
}
