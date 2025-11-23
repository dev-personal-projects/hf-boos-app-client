import 'package:flutter/material.dart';
import 'app.dart';
import 'core/network/api_client.dart';
import 'core/storage/secure_storage.dart';
import 'core/storage/local_storage.dart';

/// Main Entry Point
///
/// LEARN: This is the entry point of the Flutter app.
/// When the app starts, Dart calls this main() function.
///
/// This function:
/// 1. Initializes app services (storage, API client)
/// 2. Runs the app
///
/// LEARN: 'async' means this function can use 'await' for async operations.
/// We need this because initializing storage is async (takes time).
void main() async {
  // LEARN: WidgetsFlutterBinding ensures Flutter is initialized
  // before we do any async operations. This is required when using
  // async code in main().
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app services
  await _initializeApp();

  // Run the app
  //
  // LEARN: runApp() tells Flutter to start rendering widgets.
  // We pass BoosApp which is our root widget.
  runApp(const BoosApp());
}

/// Initialize app services
///
/// LEARN: This function sets up all the services our app needs:
/// - Local storage (for preferences)
/// - Secure storage (for tokens)
/// - API client (for network requests)
///
/// We do this before running the app so everything is ready.
Future<void> _initializeApp() async {
  // Initialize local storage
  //
  // LEARN: LocalStorage is a singleton, so we get the instance
  // and initialize it. This loads SharedPreferences.
  await LocalStorage().init();

  // Initialize secure storage and set up API client
  //
  // LEARN: We get the SecureStorage instance and set up the API client
  // to use it for getting JWT tokens. This way, every API request
  // will automatically include the token if the user is logged in.
  final secureStorage = SecureStorage();
  final apiClient = ApiClient();

  // Configure API client to get tokens from secure storage
  //
  // LEARN: We pass a function that retrieves the token from secure storage.
  // The API interceptor will call this function before each request
  // to add the token to the headers.
  //
  // LEARN: We use an arrow function (() => ...) which is a shorthand
  // for creating a function. This function returns a Future<String?>
  // because secure storage operations are async.
  apiClient.setTokenGetter(() => secureStorage.get('auth_token'));
}
