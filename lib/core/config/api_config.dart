/// API Configuration
///
/// This file contains all API-related configuration constants.
/// In Flutter, we use constants (const) for values that never change.
/// This is better for performance because the compiler can optimize them.
///
/// LEARN: In Dart, 'const' means the value is known at compile-time
/// and will never change. This is different from 'final' which can be
/// set once at runtime.
library;

class ApiConfig {
  // Private constructor prevents creating instances of this class
  // We only want to use the static constants, not create objects
  ApiConfig._();

  /// Base URL for your Azure backend API
  ///
  /// LEARN: Replace this with your actual Azure production URL
  /// Example: 'https://your-app.azurecontainerapps.io'
  /// or: 'https://api.yourdomain.com'
  ///
  /// IMPORTANT: Make sure your URL:
  /// 1. Uses HTTPS (secure connection)
  /// 2. Doesn't end with a trailing slash (/)
  /// 3. Is accessible from mobile devices
  static const String baseUrl =
      'https://your-azure-backend-url.azurecontainerapps.io';

  /// API version prefix
  /// Some APIs use versioning like /api/v1, /api/v2
  /// If your backend uses versioning, add it here
  static const String apiVersion = '/api/v1';

  /// Complete base URL with version
  /// This combines baseUrl + apiVersion
  /// Example: 'https://api.example.com/api/v1'
  static String get baseUrlWithVersion => '$baseUrl$apiVersion';

  /// Request timeout duration
  ///
  /// LEARN: Duration is a Dart class that represents a time span
  /// Duration(seconds: 30) means 30 seconds
  /// This is how long we wait for a response before giving up
  static const Duration connectTimeout = Duration(seconds: 30);

  /// Receive timeout duration
  /// How long we wait to receive data after connection is established
  static const Duration receiveTimeout = Duration(seconds: 30);

  /// Send timeout duration
  /// How long we wait to send data to the server
  static const Duration sendTimeout = Duration(seconds: 30);

  /// API Endpoints
  ///
  /// LEARN: These are the specific paths/URLs for different API operations
  /// We define them as constants so we can reuse them throughout the app
  /// and avoid typos (the compiler will catch errors if we misspell them)
  ///
  /// Example usage:
  /// final url = ApiConfig.baseUrlWithVersion + ApiConfig.endpoints.login;
  /// Result: 'https://api.example.com/api/v1/auth/login'

  // Authentication endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Business endpoints
  static const String businessRegister = '/auth/business/register';
  static const String businessList = '/auth/business';

  // Document endpoints (based on your backend API)
  static const String documents = '/documents';
  static const String createDocument = '/documents';
  static const String getDocument = '/documents'; // + /{id}
  static const String updateDocument = '/documents'; // + /{id}
  static const String deleteDocument = '/documents'; // + /{id}

  // Speech/Transcription endpoints
  static const String transcribe = '/speech/transcribe';
}
