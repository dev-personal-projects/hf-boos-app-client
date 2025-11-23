import 'package:dio/dio.dart';
import '../config/api_config.dart';
import 'api_interceptor.dart';
import 'network_exceptions.dart';

/// API Client
///
/// LEARN: This is a singleton class that manages all HTTP requests.
/// A singleton means there's only one instance of this class in the entire app.
/// This is useful for things like HTTP clients because:
/// 1. We don't want multiple instances making requests
/// 2. We can configure it once and reuse it everywhere
/// 3. It's more efficient (less memory usage)
///
/// This class wraps Dio (our HTTP client) and provides:
/// - Easy-to-use methods (get, post, put, delete)
/// - Automatic error handling
/// - Token injection
/// - Request/response logging

class ApiClient {
  /// LEARN: 'late' means this variable will be initialized later,
  /// but before it's used. It's like a promise that it will have a value.
  /// We use 'late' because we can't initialize Dio in the constructor
  /// (we need to set it up first).
  late final Dio _dio;

  /// LEARN: 'static' means this variable belongs to the class, not instances.
  /// There's only one _instance for the entire app (singleton pattern).
  /// '?' means it can be null initially.
  static ApiClient? _instance;

  /// LEARN: Private constructor prevents creating instances from outside.
  /// The '_' prefix makes it private. Only this class can create instances.
  /// This is how we enforce the singleton pattern.
  ApiClient._internal() {
    // Initialize Dio with base configuration
    //
    // LEARN: Dio is the HTTP client library we use to make API calls.
    // It's like axios in JavaScript or Retrofit in Android.
    _dio = Dio(
      BaseOptions(
        // Base URL for all requests
        //
        // LEARN: This is the root URL. All requests will be relative to this.
        // Example: If baseUrl is 'https://api.example.com' and we call
        // get('/users'), it becomes 'https://api.example.com/users'
        baseUrl: ApiConfig.baseUrlWithVersion,

        // Timeout settings
        //
        // LEARN: These prevent requests from hanging forever.
        // If the server doesn't respond within these times, we get a timeout error.
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,

        // Default headers for all requests
        //
        // LEARN: Headers are metadata sent with every request.
        // Common headers include Content-Type, Accept, Authorization, etc.
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add our custom interceptor
    //
    // LEARN: Interceptors are like middleware. They run before/after each request.
    // Our ApiInterceptor will:
    // 1. Add JWT tokens to requests
    // 2. Handle errors and convert them to custom exceptions
    // 3. Log requests/responses
    //
    // LEARN: We start with null getToken. It will be set in main() when
    // storage is initialized. The interceptor handles null gracefully.
    _dio.interceptors.add(
      ApiInterceptor(
        getToken: null, // Will be set in main() after storage initialization
      ),
    );
  }

  /// Get the singleton instance
  ///
  /// LEARN: This is the factory constructor pattern.
  /// It ensures only one instance exists. If _instance is null, create it.
  /// Otherwise, return the existing one.
  factory ApiClient() {
    // LEARN: '??=' is a null-aware assignment operator.
    // It means: if _instance is null, assign the new ApiClient to it.
    // Otherwise, keep the existing value.
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  /// Set the token getter function
  ///
  /// LEARN: This allows us to set how we get the token after the client is created.
  /// We'll call this when the user logs in and we have a token.
  ///
  /// The function should return a Future<String?> because secure storage is async.
  void setTokenGetter(Future<String?> Function()? getToken) {
    // Remove old interceptor
    _dio.interceptors.removeWhere(
      (interceptor) => interceptor is ApiInterceptor,
    );

    // Add new interceptor with token getter
    // LEARN: The interceptor will automatically load and cache the token
    _dio.interceptors.add(ApiInterceptor(getToken: getToken));
  }

  /// GET request
  ///
  /// LEARN: GET is used to retrieve data from the server.
  /// Example: Get list of invoices, get user profile, etc.
  ///
  /// Parameters:
  /// - path: The endpoint path (e.g., '/documents' or '/users/123')
  /// - queryParameters: Optional query string parameters (e.g., ?page=1&limit=10)
  /// - options: Optional request options (headers, timeout, etc.)
  ///
  /// Returns: Response data from the server
  /// Throws: AppException if something goes wrong
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      // LEARN: 'await' waits for the async operation to complete.
      // Dio.get() returns a Future (a promise that will have a value later).
      // 'await' pauses execution until the Future completes.
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      // LEARN: 'catch' handles errors. 'on DioException' means we only
      // catch DioException errors (not other types of errors).
      // The interceptor already converted it to AppException, so we rethrow it.
      throw e.error is AppException
          ? e.error as AppException
          : UnknownException(e.message);
    }
  }

  /// POST request
  ///
  /// LEARN: POST is used to create new resources or send data to the server.
  /// Example: Create invoice, login, signup, etc.
  ///
  /// Parameters:
  /// - path: The endpoint path
  /// - data: The data to send (will be converted to JSON)
  /// - queryParameters: Optional query string parameters
  /// - options: Optional request options
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : UnknownException(e.message);
    }
  }

  /// PUT request
  ///
  /// LEARN: PUT is used to update an existing resource.
  /// Example: Update invoice, update user profile, etc.
  ///
  /// PUT replaces the entire resource. If you only want to update
  /// some fields, use PATCH instead.
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : UnknownException(e.message);
    }
  }

  /// PATCH request
  ///
  /// LEARN: PATCH is used to partially update a resource.
  /// Example: Update only the status of an invoice.
  ///
  /// PATCH only updates the fields you send, unlike PUT which
  /// replaces the entire resource.
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : UnknownException(e.message);
    }
  }

  /// DELETE request
  ///
  /// LEARN: DELETE is used to remove a resource.
  /// Example: Delete invoice, delete user account, etc.
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw e.error is AppException
          ? e.error as AppException
          : UnknownException(e.message);
    }
  }

  /// Cancel all pending requests
  ///
  /// LEARN: Sometimes you want to cancel requests (e.g., user navigates away).
  /// This is useful for cleaning up when the user leaves a screen.
  void cancelAllRequests() {
    _dio.close(force: true);
  }
}
