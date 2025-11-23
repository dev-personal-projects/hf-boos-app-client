/// Network Exceptions
///
/// LEARN: In Dart/Flutter, we use exceptions to handle errors.
/// An exception is thrown when something goes wrong, and we can
/// catch it to handle the error gracefully.
///
/// This file defines custom exception classes for different types
/// of network errors. This makes it easier to:
/// 1. Know what went wrong
/// 2. Show appropriate error messages to users
/// 3. Handle errors differently based on type
///
/// LEARN: 'extends Exception' means our class inherits from the
/// built-in Exception class. This allows us to throw and catch
/// these custom exceptions.

/// Base class for all network-related exceptions
///
/// LEARN: 'abstract class' means you can't create an instance
/// of this class directly. You must create a subclass (like
/// NetworkException, ServerException, etc.)
///
/// This is useful when you want to define common behavior
/// but force each specific error type to implement its own details.
library;

abstract class AppException implements Exception {
  /// Error message that can be shown to users
  final String message;

  /// Optional error code from the server
  final int? statusCode;

  /// Constructor
  /// LEARN: 'this.message' is a shorthand way to assign the parameter
  /// to the instance variable. It's equivalent to:
  /// AppException(String message) { this.message = message; }
  const AppException(this.message, [this.statusCode]);

  /// Convert exception to a user-friendly string
  /// LEARN: 'override' means we're replacing a method from the parent class
  /// In this case, we're overriding toString() from Object class
  @override
  String toString() => message;
}

/// Exception thrown when there's no internet connection
///
/// LEARN: This is a concrete class (not abstract), so we can create
/// instances of it: throw NoInternetException('No internet');
class NoInternetException extends AppException {
  const NoInternetException([String? message])
    : super(message ?? 'No internet connection. Please check your network.');
}

/// Exception thrown when the server returns an error (4xx, 5xx)
///
/// LEARN: HTTP status codes:
/// - 4xx: Client errors (bad request, unauthorized, not found, etc.)
/// - 5xx: Server errors (internal server error, service unavailable, etc.)
class ServerException extends AppException {
  const ServerException(super.message, [super.statusCode]);
}

/// Exception thrown when request times out
///
/// LEARN: Timeout happens when the server takes too long to respond.
/// This could be due to slow network or server being overloaded.
class TimeoutException extends AppException {
  const TimeoutException([String? message])
    : super(message ?? 'Request timed out. Please try again.');
}

/// Exception thrown when the response format is unexpected
///
/// LEARN: This happens when we expect JSON but get something else,
/// or when the JSON structure doesn't match what we expect.
class FormatException extends AppException {
  const FormatException([String? message])
    : super(message ?? 'Invalid response format from server.');
}

/// Exception thrown when authentication fails (401 Unauthorized)
///
/// LEARN: 401 means the user is not authenticated or their token expired.
/// We usually handle this by redirecting to login screen.
class UnauthorizedException extends AppException {
  const UnauthorizedException([String? message])
    : super(message ?? 'Authentication failed. Please login again.', 401);
}

/// Exception thrown when user doesn't have permission (403 Forbidden)
///
/// LEARN: 403 means the user is authenticated but doesn't have permission
/// to access the resource.
class ForbiddenException extends AppException {
  const ForbiddenException([String? message])
    : super(
        message ?? 'You don\'t have permission to access this resource.',
        403,
      );
}

/// Exception thrown when resource is not found (404 Not Found)
class NotFoundException extends AppException {
  const NotFoundException([String? message])
    : super(message ?? 'The requested resource was not found.', 404);
}

/// Exception thrown for other unexpected errors
class UnknownException extends AppException {
  const UnknownException([String? message])
    : super(message ?? 'An unexpected error occurred. Please try again.');
}
