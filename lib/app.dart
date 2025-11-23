import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/storage/local_storage.dart';

/// Boos App
///
/// LEARN: This is the main widget that represents our entire app.
/// It's separated from main.dart to keep the entry point clean.
///
/// This widget:
/// 1. Sets up the MaterialApp with themes
/// 2. Manages theme state (light/dark mode)
/// 3. Provides the app structure
///
/// LEARN: StatefulWidget vs StatelessWidget:
/// - StatelessWidget: Widget that doesn't change (static)
/// - StatefulWidget: Widget that can change (has state)
/// We use StatefulWidget because theme mode can change.

class BoosApp extends StatefulWidget {
  const BoosApp({super.key});

  @override
  State<BoosApp> createState() => _BoosAppState();
}

class _BoosAppState extends State<BoosApp> {
  /// Current theme mode
  ///
  /// LEARN: ThemeMode is an enum with three values:
  /// - ThemeMode.light: Always light theme
  /// - ThemeMode.dark: Always dark theme
  /// - ThemeMode.system: Follows device theme (default)
  ///
  /// We start with system mode to follow device settings.
  /// User preference is saved to local storage.
  ThemeMode _themeMode = ThemeMode.system;

  /// Initialize theme mode from storage
  ///
  /// LEARN: This loads the saved theme preference when the app starts.
  /// If no preference is saved, it defaults to system theme.
  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  /// Load theme mode from local storage
  ///
  /// LEARN: We check if a theme preference was saved.
  /// If yes, use it. If no, use system theme.
  Future<void> _loadThemeMode() async {
    final localStorage = LocalStorage();
    final savedTheme = localStorage.getString('theme_mode');

    if (savedTheme != null) {
      setState(() {
        _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == savedTheme,
          orElse: () => ThemeMode.system,
        );
      });
    }
  }

  /// Save theme mode to local storage
  ///
  /// LEARN: We save the user's theme preference so it persists
  /// across app restarts.
  Future<void> _saveThemeMode(ThemeMode mode) async {
    final localStorage = LocalStorage();
    await localStorage.saveString('theme_mode', mode.toString());
  }

  /// Cycle through theme modes
  ///
  /// LEARN: This cycles through: system -> light -> dark -> system
  /// This gives users three options: follow system, force light, or force dark.
  void _toggleTheme() {
    setState(() {
      switch (_themeMode) {
        case ThemeMode.system:
          _themeMode = ThemeMode.light;
        case ThemeMode.light:
          _themeMode = ThemeMode.dark;
        case ThemeMode.dark:
          _themeMode = ThemeMode.system;
      }
      // Save preference
      _saveThemeMode(_themeMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    // LEARN: MaterialApp is the root widget that provides:
    // - Theme system
    // - Navigation
    // - Localization
    // - Other Material Design features
    return MaterialApp(
      /// App title (shown in task switcher, etc.)
      title: 'Boos',

      /// Light theme configuration
      ///
      /// LEARN: theme is used when ThemeMode is light or system (and device is light)
      theme: AppTheme.lightTheme,

      /// Dark theme configuration
      ///
      /// LEARN: darkTheme is used when ThemeMode is dark or system (and device is dark)
      darkTheme: AppTheme.darkTheme,

      /// Current theme mode
      ///
      /// LEARN: This determines which theme to use
      themeMode: _themeMode,

      /// Hide the debug banner in the top-right corner
      debugShowCheckedModeBanner: false,

      /// Home screen
      ///
      /// LEARN: This is the first screen shown when the app opens.
      /// We pass the theme toggle function so the home screen can change themes.
      home: MyHomePage(onThemeToggle: _toggleTheme),
    );
  }
}

/// Home Page Widget
///
/// LEARN: This is the main screen of the app.
/// It's a simple screen that shows the app title and a theme toggle button.
///
/// In a real app, this would be replaced with your actual home screen
/// (like a dashboard, list of documents, etc.)
class MyHomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const MyHomePage({super.key, required this.onThemeToggle});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // LEARN: We get the current brightness from the theme.
    // This reflects the actual theme being used (including system theme).
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Boos'),
        actions: [
          // LEARN: We show different icons based on current theme.
          // This gives visual feedback about the current theme mode.
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
            tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello, World!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
