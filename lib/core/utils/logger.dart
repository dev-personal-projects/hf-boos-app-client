import 'package:flutter/foundation.dart' show kDebugMode;

/// Logger
///
/// LEARN: This file provides centralized logging for the app.
/// Logging helps with debugging and monitoring app behavior.
///
/// Why use a logger?
/// 1. Debugging - See what's happening in the app
/// 2. Error tracking - Find and fix bugs
/// 3. Performance monitoring - Track slow operations
/// 4. User behavior - Understand how users use the app
///
/// LEARN: We use different log levels:
/// - debug: Development info (only in debug mode)
/// - info: General information
/// - warning: Something unexpected but not critical
/// - error: Errors that need attention
///
/// IMPORTANT: Logs are only shown in debug mode (kDebugMode).
/// In production, logs are disabled for performance and security.

class AppLogger {
  // Private constructor prevents creating instances
  AppLogger._();

  // ============================================================================
  // LOG LEVELS
  // ============================================================================

  /// Log debug message
  ///
  /// LEARN: Debug logs are for development only.
  /// They show detailed information about what's happening.
  ///
  /// Example:
  /// AppLogger.debug('User logged in', {'userId': '123'});
  ///
  /// Parameters:
  /// - message: The log message
  /// - data: Optional additional data (Map, List, etc.)
  static void debug(String message, [dynamic data]) {
    if (kDebugMode) {
      _log('🐛 DEBUG', message, data);
    }
  }

  /// Log info message
  ///
  /// LEARN: Info logs are for general information.
  /// Use for: User actions, successful operations, etc.
  ///
  /// Example:
  /// AppLogger.info('Document created successfully');
  ///
  /// Parameters:
  /// - message: The log message
  /// - data: Optional additional data
  static void info(String message, [dynamic data]) {
    if (kDebugMode) {
      _log('ℹ️ INFO', message, data);
    }
  }

  /// Log warning message
  ///
  /// LEARN: Warnings are for unexpected but non-critical situations.
  /// Use for: Deprecated features, fallback behavior, etc.
  ///
  /// Example:
  /// AppLogger.warning('Using default value', {'field': 'theme'});
  ///
  /// Parameters:
  /// - message: The log message
  /// - data: Optional additional data
  static void warning(String message, [dynamic data]) {
    if (kDebugMode) {
      _log('⚠️ WARNING', message, data);
    }
  }

  /// Log error message
  ///
  /// LEARN: Errors are for critical issues that need attention.
  /// Use for: Exceptions, failed operations, etc.
  ///
  /// Example:
  /// AppLogger.error('Failed to load documents', error);
  ///
  /// Parameters:
  /// - message: The log message
  /// - error: The error object (Exception, Error, etc.)
  /// - stackTrace: Optional stack trace for debugging
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _log('❌ ERROR', message, error);
      if (stackTrace != null) {
        // ignore: avoid_print
        print('📍 Stack Trace:');
        // ignore: avoid_print
        print(stackTrace);
      }
    }
  }

  // ============================================================================
  // PRIVATE HELPER
  // ============================================================================

  /// Internal logging method
  ///
  /// LEARN: This is a private method (starts with _) that handles
  /// the actual logging. It formats the message nicely.
  ///
  /// Parameters:
  /// - level: The log level emoji and label
  /// - message: The log message
  /// - data: Optional additional data
  static void _log(String level, String message, [dynamic data]) {
    final timestamp = DateTime.now().toIso8601String();
    print('[$timestamp] $level: $message');

    if (data != null) {
      print('   Data: $data');
    }
  }

  // ============================================================================
  // SPECIALIZED LOGGERS
  // ============================================================================

  /// Log API request
  ///
  /// LEARN: Specialized logger for API calls.
  /// Makes it easy to track network requests.
  ///
  /// Parameters:
  /// - method: HTTP method (GET, POST, etc.)
  /// - url: The API endpoint
  /// - data: Optional request data
  static void apiRequest(String method, String url, [dynamic data]) {
    if (kDebugMode) {
      debug('API Request: $method $url', data);
    }
  }

  /// Log API response
  ///
  /// LEARN: Specialized logger for API responses.
  ///
  /// Parameters:
  /// - statusCode: HTTP status code
  /// - url: The API endpoint
  /// - data: Optional response data
  static void apiResponse(int statusCode, String url, [dynamic data]) {
    if (kDebugMode) {
      if (statusCode >= 200 && statusCode < 300) {
        info('API Response: $statusCode $url', data);
      } else {
        warning('API Response: $statusCode $url', data);
      }
    }
  }

  /// Log navigation event
  ///
  /// LEARN: Track user navigation for analytics/debugging.
  ///
  /// Parameters:
  /// - route: The route being navigated to
  static void navigation(String route) {
    if (kDebugMode) {
      debug('Navigation: $route');
    }
  }

  /// Log user action
  ///
  /// LEARN: Track user actions for analytics.
  ///
  /// Parameters:
  /// - action: The action name (e.g., 'button_clicked', 'form_submitted')
  /// - data: Optional action data
  static void userAction(String action, [dynamic data]) {
    if (kDebugMode) {
      info('User Action: $action', data);
    }
  }
}
