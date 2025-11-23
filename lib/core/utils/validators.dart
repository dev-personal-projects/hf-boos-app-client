/// Validators
///
/// LEARN: This file contains validation functions for user input.
/// Validation ensures data is correct before sending to the server.
///
/// Why validate?
/// 1. Better user experience (catch errors early)
/// 2. Security (prevent malicious input)
/// 3. Data quality (ensure correct format)
/// 4. Server efficiency (less invalid requests)
///
/// LEARN: These functions return String? (nullable String).
/// - null = valid (no error)
/// - String = error message to show user
library;

class Validators {
  // Private constructor prevents creating instances
  Validators._();

  // ============================================================================
  // EMAIL VALIDATION
  // ============================================================================

  /// Validate email address
  ///
  /// LEARN: Email validation uses regex (regular expression) to check format.
  /// Regex is a pattern matching language. This pattern checks for:
  /// - Text before @
  /// - @ symbol
  /// - Domain name
  /// - Top-level domain (.com, .org, etc.)
  ///
  /// Parameters:
  /// - email: The email string to validate
  ///
  /// Returns: null if valid, error message if invalid
  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    // LEARN: RegExp is Dart's regular expression class.
    // This pattern matches standard email format.
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null; // Valid
  }

  // ============================================================================
  // PASSWORD VALIDATION
  // ============================================================================

  /// Validate password
  ///
  /// LEARN: Password validation checks:
  /// 1. Not empty
  /// 2. Minimum length (from AppConstants)
  /// 3. Contains at least one letter
  /// 4. Contains at least one number (optional, can be removed)
  ///
  /// Parameters:
  /// - password: The password string to validate
  ///
  /// Returns: null if valid, error message if invalid
  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    // Check minimum length
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for at least one letter
    if (!RegExp(r'[a-zA-Z]').hasMatch(password)) {
      return 'Password must contain at least one letter';
    }

    // Optional: Check for at least one number
    // Uncomment if you want to require numbers
    // if (!RegExp(r'[0-9]').hasMatch(password)) {
    //   return 'Password must contain at least one number';
    // }

    return null; // Valid
  }

  /// Validate password confirmation
  ///
  /// LEARN: This ensures the user typed the same password twice.
  /// Used in signup forms.
  ///
  /// Parameters:
  /// - password: Original password
  /// - confirmPassword: Confirmation password
  ///
  /// Returns: null if valid, error message if invalid
  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null; // Valid
  }

  // ============================================================================
  // PHONE VALIDATION
  // ============================================================================

  /// Validate phone number (Kenyan format)
  ///
  /// LEARN: Kenyan phone numbers typically:
  /// - Start with +254 or 0
  /// - Format: +254712345678 or 0712345678
  /// - 9 digits after country code
  ///
  /// Parameters:
  /// - phone: The phone string to validate
  ///
  /// Returns: null if valid, error message if invalid
  static String? phone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }

    // Remove spaces and dashes for validation
    final cleanedPhone = phone.replaceAll(RegExp(r'[\s-]'), '');

    // Check for Kenyan format: +254XXXXXXXXX or 0XXXXXXXXX
    final phoneRegex = RegExp(r'^(\+254|0)[17]\d{8}$');

    if (!phoneRegex.hasMatch(cleanedPhone)) {
      return 'Please enter a valid Kenyan phone number';
    }

    return null; // Valid
  }

  // ============================================================================
  // TEXT VALIDATION
  // ============================================================================

  /// Validate required text field
  ///
  /// LEARN: Simple validation for required fields.
  /// Use for: names, addresses, descriptions, etc.
  ///
  /// Parameters:
  /// - value: The text to validate
  /// - fieldName: Name of the field (for error message)
  ///
  /// Returns: null if valid, error message if invalid
  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null; // Valid
  }

  /// Validate text length
  ///
  /// LEARN: Ensures text is within min/max length.
  /// Use for: descriptions, comments, etc.
  ///
  /// Parameters:
  /// - value: The text to validate
  /// - minLength: Minimum characters required
  /// - maxLength: Maximum characters allowed
  /// - fieldName: Name of the field (for error message)
  ///
  /// Returns: null if valid, error message if invalid
  static String? length(
    String? value,
    int minLength,
    int maxLength,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }

    return null; // Valid
  }

  // ============================================================================
  // NUMBER VALIDATION
  // ============================================================================

  /// Validate positive number
  ///
  /// LEARN: Ensures a number is positive (greater than 0).
  /// Use for: prices, quantities, amounts, etc.
  ///
  /// Parameters:
  /// - value: The number string to validate
  /// - fieldName: Name of the field (for error message)
  ///
  /// Returns: null if valid, error message if invalid
  static String? positiveNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    // Try to parse as double
    final number = double.tryParse(value);
    if (number == null) {
      return '$fieldName must be a valid number';
    }

    if (number <= 0) {
      return '$fieldName must be greater than 0';
    }

    return null; // Valid
  }

  // ============================================================================
  // BUSINESS VALIDATION
  // ============================================================================

  /// Validate business name
  ///
  /// LEARN: Business name validation with length check.
  ///
  /// Parameters:
  /// - name: The business name to validate
  ///
  /// Returns: null if valid, error message if invalid
  static String? businessName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Business name is required';
    }

    if (name.length < 2) {
      return 'Business name must be at least 2 characters';
    }

    if (name.length > 100) {
      return 'Business name must not exceed 100 characters';
    }

    return null; // Valid
  }
}
