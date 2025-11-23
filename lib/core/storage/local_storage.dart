import 'package:shared_preferences/shared_preferences.dart';

/// Local Storage Service
///
/// LEARN: This service handles storing non-sensitive user preferences.
/// It uses platform-specific storage:
/// - iOS: UserDefaults
/// - Android: SharedPreferences
///
/// Use this for:
/// - Theme preferences (light/dark mode)
/// - Language settings
/// - App settings
/// - User preferences
/// - Any non-sensitive data
///
/// LEARN: SharedPreferences stores data as key-value pairs.
/// It's simple but not encrypted, so don't store sensitive data here.

class LocalStorage {
  // Private constructor
  LocalStorage._internal();

  // Singleton instance
  static LocalStorage? _instance;

  // Get singleton instance
  factory LocalStorage() {
    _instance ??= LocalStorage._internal();
    return _instance!;
  }

  // SharedPreferences instance
  // LEARN: We'll initialize this when the app starts
  SharedPreferences? _prefs;

  /// Initialize the storage
  ///
  /// LEARN: This must be called before using the storage.
  /// We call it in main() when the app starts.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save a string value
  Future<bool> saveString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// Get a string value
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Save a boolean value
  Future<bool> saveBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  /// Get a boolean value
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// Save an integer value
  Future<bool> saveInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  /// Get an integer value
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Remove a value
  Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Clear all stored values
  Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  /// Check if a key exists
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }
}
