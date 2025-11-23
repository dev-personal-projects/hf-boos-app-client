import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure Storage Service
///
/// LEARN: This service handles storing sensitive data securely.
/// It uses platform-specific secure storage:
/// - iOS: Keychain (encrypted storage)
/// - Android: Keystore (hardware-backed encryption)
///
/// Use this for:
/// - JWT tokens
/// - API keys
/// - Passwords
/// - Any sensitive user data
///
/// LEARN: Singleton pattern - only one instance exists.
/// This ensures we don't create multiple storage instances.

class SecureStorage {
  // Private constructor prevents creating instances from outside
  SecureStorage._internal();

  // Singleton instance
  static SecureStorage? _instance;

  // Get singleton instance
  factory SecureStorage() {
    _instance ??= SecureStorage._internal();
    return _instance!;
  }

  // Flutter Secure Storage instance
  // LEARN: This creates a secure storage instance for storing sensitive data
  // The storage is automatically encrypted on both iOS and Android
  final _storage = const FlutterSecureStorage();

  /// Save a value securely
  ///
  /// LEARN: 'Future' means this is an async operation (takes time).
  /// We use 'await' when calling this to wait for it to complete.
  ///
  /// Example:
  /// await secureStorage.save('token', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...');
  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Get a value from secure storage
  ///
  /// Returns null if the key doesn't exist.
  ///
  /// Example:
  /// final token = await secureStorage.get('token');
  Future<String?> get(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a value from secure storage
  ///
  /// Example:
  /// await secureStorage.delete('token');
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Delete all values from secure storage
  ///
  /// Useful for logout - clears all sensitive data.
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Check if a key exists
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}
