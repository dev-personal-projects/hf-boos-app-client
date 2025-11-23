import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'network_exceptions.dart';

/// API Interceptor
///
/// LEARN: An interceptor is like a middleware that runs before and after
/// each HTTP request. It's similar to middleware in Express.js or
/// interceptors in Axios.
///
/// In Dio (our HTTP client), interceptors can:
/// 1. Modify requests before they're sent (add headers, tokens, etc.)
/// 2. Handle responses (parse data, check errors)
/// 3. Handle errors (convert to custom exceptions)
///
/// This interceptor does three main things:
/// 1. Adds JWT token to requests (if user is logged in)
/// 2. Handles errors and converts them to our custom exceptions
/// 3. Logs requests/responses for debugging

class ApiInterceptor extends Interceptor {
  /// Function to get the current JWT token (async)
  ///
  /// LEARN: This is a function type that returns a Future<String?>
  /// We'll pass a function from our storage service that retrieves the token.
  /// This is dependency injection - we don't hardcode where the token comes from.
  final Future<String?> Function()? getToken;

  /// Cached token to avoid async calls in onRequest
  ///
  /// LEARN: Since onRequest can't be async, we cache the token
  /// and refresh it periodically or when it's null.
  String? _cachedToken;

  /// Constructor
  ///
  /// LEARN: 'this.getToken' is a shorthand for assigning the parameter
  /// to the instance variable. The '?' means it's optional (can be null).
  ApiInterceptor({this.getToken}) {
    // Pre-load token if getter is provided
    _refreshToken();
  }

  /// Refresh the cached token
  ///
  /// LEARN: This loads the token from storage and caches it.
  /// We call this when the interceptor is created and when needed.
  Future<void> _refreshToken() async {
    if (getToken != null) {
      _cachedToken = await getToken!();
    }
  }

  /// Called before a request is sent
  ///
  /// LEARN: 'onRequest' is called automatically by Dio before each request.
  /// We can modify the request here (add headers, change URL, etc.)
  ///
  /// 'RequestOptions' contains all information about the request:
  /// - path: the URL endpoint
  /// - method: GET, POST, PUT, DELETE, etc.
  /// - headers: HTTP headers
  /// - data: request body
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add JWT token to request headers if available
    //
    // LEARN: JWT (JSON Web Token) is a way to authenticate users.
    // When a user logs in, the server gives them a token.
    // We send this token with every request to prove who we are.
    //
    // The format is usually: 'Bearer <token>'
    // Example: 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
    if (_cachedToken != null && _cachedToken!.isNotEmpty) {
      // LEARN: 'options.headers' is a Map that holds HTTP headers
      // We add the Authorization header with the token
      options.headers['Authorization'] = 'Bearer $_cachedToken';
    }

    // Refresh token asynchronously if it's not cached
    // LEARN: We do this in the background so it doesn't block the request
    if (getToken != null && _cachedToken == null) {
      _refreshToken();
    }

    // Add common headers
    //
    // LEARN: These headers tell the server:
    // - Content-Type: What format our data is in (JSON)
    // - Accept: What format we want the response in (JSON)
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    // Log request for debugging (only in debug mode)
    //
    // LEARN: 'kDebugMode' is a Flutter constant that's true only in debug mode.
    // This means logging won't happen in production (better performance).
    // We use 'print' to output to console (like console.log in JavaScript).
    if (kDebugMode) {
      print('🌐 REQUEST: ${options.method} ${options.path}');
      if (options.data != null) {
        print('📦 BODY: ${options.data}');
      }
      if (options.headers.containsKey('Authorization')) {
        print('🔑 AUTH: Token present');
      }
    }

    // Continue with the request
    //
    // LEARN: 'handler.next(options)' tells Dio to continue processing
    // the request. If we don't call this, the request won't be sent.
    handler.next(options);
  }

  /// Called when a response is received
  ///
  /// LEARN: This runs after we get a response from the server.
  /// We can modify the response or log it here.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log successful response
    if (kDebugMode) {
      print(
        '✅ RESPONSE: ${response.statusCode} ${response.requestOptions.path}',
      );
      if (response.data != null) {
        print('📦 DATA: ${response.data}');
      }
    }

    // Continue with the response
    handler.next(response);
  }

  /// Called when an error occurs
  ///
  /// LEARN: This is where we convert Dio errors into our custom exceptions.
  /// This makes error handling consistent throughout the app.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log error for debugging
    if (kDebugMode) {
      print('❌ ERROR: ${err.type} - ${err.message}');
      print('📍 PATH: ${err.requestOptions.path}');
      if (err.response != null) {
        print('📊 STATUS: ${err.response?.statusCode}');
        print('📦 DATA: ${err.response?.data}');
      }
    }

    // Convert DioException to our custom AppException
    //
    // LEARN: 'switch' is like if-else but cleaner for multiple conditions.
    // 'err.type' is an enum that tells us what kind of error occurred.
    AppException exception;

    switch (err.type) {
      // No internet connection
      //
      // LEARN: DioExceptionType.connectionTimeout happens when we can't
      // connect to the server (usually no internet).
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = const TimeoutException();

      // Connection error (no internet, server down, etc.)
      case DioExceptionType.connectionError:
        exception = const NoInternetException();

      // Server returned an error response (4xx, 5xx)
      //
      // LEARN: This happens when the server responds but with an error status code.
      // We check the status code to determine the specific error.
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final errorMessage = _extractErrorMessage(err.response?.data);

        switch (statusCode) {
          case 401:
            exception = UnauthorizedException(errorMessage);
          case 403:
            exception = ForbiddenException(errorMessage);
          case 404:
            exception = NotFoundException(errorMessage);
          case 500:
          case 502:
          case 503:
            exception = ServerException(
              errorMessage ?? 'Server error. Please try again later.',
              statusCode,
            );
          default:
            exception = ServerException(
              errorMessage ?? 'An error occurred. Please try again.',
              statusCode,
            );
        }

      // Request was cancelled
      case DioExceptionType.cancel:
        exception = const UnknownException('Request was cancelled.');

      // Unknown error
      default:
        exception = UnknownException(err.message);
    }

    // Return the custom exception
    //
    // LEARN: We use 'handler.reject' to tell Dio that we've handled
    // the error and want to use our custom exception instead.
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }

  /// Extract error message from server response
  ///
  /// LEARN: Different APIs return errors in different formats:
  /// - Some use: { "error": "message" }
  /// - Some use: { "message": "error" }
  /// - Some use: { "error": { "message": "..." } }
  ///
  /// This function tries to extract the message from common formats.
  String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    // If data is already a string, return it
    if (data is String) return data;

    // If data is a Map (JSON object), try to find the message
    //
    // LEARN: 'is Map' checks if data is a Map type (like a JSON object).
    // 'as Map<String, dynamic>' tells Dart to treat it as a Map with
    // String keys and dynamic values (any type).
    if (data is Map<String, dynamic>) {
      // Try common error message keys
      return data['message'] as String? ??
          data['error'] as String? ??
          data['errorMessage'] as String? ??
          (data['error'] is Map
              ? (data['error'] as Map)['message'] as String?
              : null);
    }

    return null;
  }
}
