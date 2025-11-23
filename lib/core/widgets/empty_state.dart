import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

/// Empty State Widget
///
/// LEARN: This widget is shown when there's no data to display.
/// It provides a better user experience than showing a blank screen.
///
/// Use cases:
/// - Empty lists (no documents, no invoices, etc.)
/// - No search results
/// - No data after filtering
/// - Initial state before data loads
///
/// LEARN: Empty states are important for UX. They:
/// 1. Explain why the screen is empty
/// 2. Guide users on what to do next
/// 3. Make the app feel more polished

class EmptyState extends StatelessWidget {
  /// Icon to display
  final IconData icon;

  /// Title text
  final String title;

  /// Description text (optional)
  final String? description;

  /// Action button (optional)
  ///
  /// LEARN: This is a widget, so you can pass any button.
  /// Usually a CustomButton or ElevatedButton.
  final Widget? actionButton;

  /// Custom icon size
  final double? iconSize;

  /// Custom icon color
  final Color? iconColor;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.actionButton,
    this.iconSize,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultIconColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.spacingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              icon,
              size: iconSize ?? 64,
              color: iconColor ?? defaultIconColor,
            ),

            SizedBox(height: AppConstants.spacingL),

            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),

            // Description (if provided)
            if (description != null) ...[
              SizedBox(height: AppConstants.spacingM),
              Text(
                description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                textAlign: TextAlign.center,
              ),
            ],

            // Action button (if provided)
            if (actionButton != null) ...[
              SizedBox(height: AppConstants.spacingXL),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Predefined Empty States
///
/// LEARN: This class provides common empty state configurations.
/// Use these for common scenarios instead of creating new ones each time.

class EmptyStates {
  EmptyStates._();

  /// No documents empty state
  ///
  /// LEARN: Use this when there are no documents to show.
  static Widget noDocuments({
    VoidCallback? onActionPressed,
  }) {
    return EmptyState(
      icon: Icons.description_outlined,
      title: 'No Documents',
      description: 'You haven\'t created any documents yet.\nGet started by creating your first document.',
      actionButton: onActionPressed != null
          ? ElevatedButton.icon(
              onPressed: onActionPressed,
              icon: const Icon(Icons.add),
              label: const Text('Create Document'),
            )
          : null,
    );
  }

  /// No search results empty state
  ///
  /// LEARN: Use this when a search returns no results.
  static Widget noSearchResults({
    String? searchQuery,
  }) {
    return EmptyState(
      icon: Icons.search_off,
      title: 'No Results Found',
      description: searchQuery != null
          ? 'No results found for "$searchQuery".\nTry a different search term.'
          : 'No results found.\nTry adjusting your search.',
    );
  }

  /// No internet empty state
  ///
  /// LEARN: Use this when there's no internet connection.
  static Widget noInternet({
    VoidCallback? onRetryPressed,
  }) {
    return EmptyState(
      icon: Icons.wifi_off,
      title: 'No Internet Connection',
      description: 'Please check your internet connection and try again.',
      actionButton: onRetryPressed != null
          ? ElevatedButton.icon(
              onPressed: onRetryPressed,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            )
          : null,
    );
  }

  /// Error empty state
  ///
  /// LEARN: Use this when something goes wrong.
  static Widget error({
    String? message,
    VoidCallback? onRetryPressed,
  }) {
    return EmptyState(
      icon: Icons.error_outline,
      title: 'Something Went Wrong',
      description: message ?? 'An error occurred. Please try again.',
      actionButton: onRetryPressed != null
          ? ElevatedButton.icon(
              onPressed: onRetryPressed,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            )
          : null,
    );
  }

  /// Empty list empty state
  ///
  /// LEARN: Generic empty state for any empty list.
  static Widget emptyList({
    required String itemName,
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    return EmptyState(
      icon: Icons.inbox_outlined,
      title: 'No $itemName',
      description: 'You don\'t have any $itemName yet.',
      actionButton: onActionPressed != null
          ? ElevatedButton.icon(
              onPressed: onActionPressed,
              icon: const Icon(Icons.add),
              label: Text(actionLabel ?? 'Add $itemName'),
            )
          : null,
    );
  }
}

