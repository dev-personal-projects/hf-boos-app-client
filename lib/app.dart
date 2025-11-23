import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

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
  /// Current theme mode (light or dark)
  ///
  /// LEARN: ThemeMode is an enum with three values:
  /// - ThemeMode.light: Always light theme
  /// - ThemeMode.dark: Always dark theme
  /// - ThemeMode.system: Follows device theme
  ///
  /// We start with light mode, but this could be loaded from storage.
  ThemeMode _themeMode = ThemeMode.light;

  /// Toggle between light and dark theme
  ///
  /// LEARN: setState() tells Flutter that something changed and
  /// the UI needs to be rebuilt. Without it, changes won't be visible.
  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boos'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: widget.onThemeToggle,
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello, World!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
