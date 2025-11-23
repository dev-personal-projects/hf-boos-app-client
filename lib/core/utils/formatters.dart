import 'package:intl/intl.dart';

/// Formatters
///
/// LEARN: This file contains functions to format data for display.
/// Formatting makes data readable and consistent throughout the app.
///
/// Why format?
/// 1. User-friendly display (dates, currency, numbers)
/// 2. Consistency (same format everywhere)
/// 3. Localization (different formats for different countries)
/// 4. Professional appearance
///
/// LEARN: We use the 'intl' package for formatting.
/// It handles locale-specific formatting automatically.

class Formatters {
  // Private constructor prevents creating instances
  Formatters._();

  // ============================================================================
  // CURRENCY FORMATTING (KES - Kenyan Shilling)
  // ============================================================================

  /// Format number as Kenyan Shilling (KES)
  ///
  /// LEARN: Currency formatting adds:
  /// - Currency symbol (KES)
  /// - Thousand separators (commas)
  /// - Decimal places (2 for currency)
  ///
  /// Example:
  /// - Input: 1000.5
  /// - Output: "KES 1,000.50"
  ///
  /// Parameters:
  /// - amount: The number to format
  ///
  /// Returns: Formatted currency string
  static String currency(double amount) {
    // LEARN: NumberFormat is from the intl package.
    // It formats numbers according to locale rules.
    final formatter = NumberFormat.currency(symbol: 'KES ', decimalDigits: 2);

    return formatter.format(amount);
  }

  /// Format number as currency without symbol
  ///
  /// LEARN: Sometimes you want just the formatted number without "KES".
  /// Use this when the currency is clear from context.
  ///
  /// Example:
  /// - Input: 1000.5
  /// - Output: "1,000.50"
  ///
  /// Parameters:
  /// - amount: The number to format
  ///
  /// Returns: Formatted number string
  static String currencyWithoutSymbol(double amount) {
    final formatter = NumberFormat('#,##0.00');

    return formatter.format(amount);
  }

  // ============================================================================
  // DATE FORMATTING
  // ============================================================================

  /// Format date as "DD MMM YYYY" (e.g., "23 Nov 2024")
  ///
  /// LEARN: Date formatting converts DateTime objects to readable strings.
  /// This format is common and easy to read.
  ///
  /// Example:
  /// - Input: DateTime(2024, 11, 23)
  /// - Output: "23 Nov 2024"
  ///
  /// Parameters:
  /// - date: The DateTime object to format
  ///
  /// Returns: Formatted date string
  static String dateShort(DateTime date) {
    final formatter = DateFormat('dd MMM yyyy');

    return formatter.format(date);
  }

  /// Format date as "DD MMMM YYYY" (e.g., "23 November 2024")
  ///
  /// LEARN: Full month name format for more formal display.
  ///
  /// Example:
  /// - Input: DateTime(2024, 11, 23)
  /// - Output: "23 November 2024"
  ///
  /// Parameters:
  /// - date: The DateTime object to format
  ///
  /// Returns: Formatted date string
  static String dateLong(DateTime date) {
    final formatter = DateFormat('dd MMMM yyyy');

    return formatter.format(date);
  }

  /// Format date and time (e.g., "23 Nov 2024, 10:30 AM")
  ///
  /// LEARN: Includes both date and time for timestamps.
  ///
  /// Example:
  /// - Input: DateTime(2024, 11, 23, 10, 30)
  /// - Output: "23 Nov 2024, 10:30 AM"
  ///
  /// Parameters:
  /// - date: The DateTime object to format
  ///
  /// Returns: Formatted date and time string
  static String dateTime(DateTime date) {
    final formatter = DateFormat('dd MMM yyyy, hh:mm a');

    return formatter.format(date);
  }

  /// Format date as relative time (e.g., "2 hours ago", "Yesterday")
  ///
  /// LEARN: Relative time is more user-friendly for recent dates.
  /// Shows "Today", "Yesterday", "X days ago", or actual date if older.
  ///
  /// Parameters:
  /// - date: The DateTime object to format
  ///
  /// Returns: Relative time string
  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    // Today
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      }
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    }

    // Yesterday
    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    // This week
    if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    }

    // Older - show actual date
    return dateShort(date);
  }

  // ============================================================================
  // NUMBER FORMATTING
  // ============================================================================

  /// Format number with thousand separators
  ///
  /// LEARN: Adds commas to large numbers for readability.
  ///
  /// Example:
  /// - Input: 1000
  /// - Output: "1,000"
  ///
  /// Parameters:
  /// - number: The number to format
  ///
  /// Returns: Formatted number string
  static String number(double number) {
    final formatter = NumberFormat('#,##0');

    return formatter.format(number);
  }

  /// Format number with decimal places
  ///
  /// LEARN: Shows specific number of decimal places.
  ///
  /// Example:
  /// - Input: 1000.5, decimals: 2
  /// - Output: "1,000.50"
  ///
  /// Parameters:
  /// - number: The number to format
  /// - decimals: Number of decimal places
  ///
  /// Returns: Formatted number string
  static String numberWithDecimals(double number, int decimals) {
    final formatter = NumberFormat('#,##0.${'0' * decimals}');

    return formatter.format(number);
  }

  // ============================================================================
  // PHONE FORMATTING
  // ============================================================================

  /// Format phone number for display
  ///
  /// LEARN: Formats Kenyan phone numbers for better readability.
  /// Converts +254712345678 to +254 712 345 678
  ///
  /// Parameters:
  /// - phone: The phone number string
  ///
  /// Returns: Formatted phone string
  static String phone(String phone) {
    // Remove all non-digits except +
    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');

    // Format: +254 712 345 678
    if (cleaned.startsWith('+254')) {
      final digits = cleaned.substring(4);
      if (digits.length == 9) {
        return '+254 ${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
      }
    }

    // Format: 0712 345 678
    if (cleaned.startsWith('0') && cleaned.length == 10) {
      final digits = cleaned.substring(1);
      return '0${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    }

    // Return as-is if format doesn't match
    return phone;
  }
}
