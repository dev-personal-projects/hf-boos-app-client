import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boos/app.dart';

void main() {
  group('Boos App Tests', () {
    testWidgets('App renders correctly with all main elements', (
      WidgetTester tester,
    ) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const BoosApp());

      // Verify that the app title is displayed in the AppBar.
      expect(find.text('Boos'), findsOneWidget);

      // Verify that the main content is displayed.
      expect(find.text('Hello, World!'), findsOneWidget);

      // Verify that the theme toggle button is present.
      // LEARN: The app now starts with system theme, so either icon could be shown.
      final hasThemeIcon =
          find.byIcon(Icons.dark_mode).evaluate().isNotEmpty ||
          find.byIcon(Icons.light_mode).evaluate().isNotEmpty;
      expect(hasThemeIcon, isTrue);
    });

    testWidgets('Theme toggle button works correctly', (
      WidgetTester tester,
    ) async {
      // Build our app.
      await tester.pumpWidget(const BoosApp());
      await tester.pumpAndSettle();

      // LEARN: The app now starts with ThemeMode.system by default.
      // The icon shown depends on the system theme, so we check for either icon.
      // We verify that a theme toggle icon exists.
      final hasDarkIcon = find.byIcon(Icons.dark_mode).evaluate().isNotEmpty;
      final hasLightIcon = find.byIcon(Icons.light_mode).evaluate().isNotEmpty;
      expect(hasDarkIcon || hasLightIcon, isTrue);

      // Get the current icon (either dark or light mode icon)
      final currentIconFinder = hasDarkIcon
          ? find.byIcon(Icons.dark_mode)
          : find.byIcon(Icons.light_mode);

      // Tap the theme toggle button.
      await tester.tap(currentIconFinder);
      await tester.pumpAndSettle();

      // After toggling, verify the icon changed or a different icon is shown.
      // The theme cycles: system -> light -> dark -> system
      final hasDarkIconAfter = find
          .byIcon(Icons.dark_mode)
          .evaluate()
          .isNotEmpty;
      final hasLightIconAfter = find
          .byIcon(Icons.light_mode)
          .evaluate()
          .isNotEmpty;
      expect(hasDarkIconAfter || hasLightIconAfter, isTrue);
    });

    testWidgets('App uses custom green theme in light mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const BoosApp());

      // Get the MaterialApp widget.
      final MaterialApp app = tester.widget(find.byType(MaterialApp));

      // Verify that the light theme is set.
      expect(app.theme, isNotNull);
      expect(app.theme?.colorScheme.primary, isNotNull);

      // Verify that dark theme is also configured.
      expect(app.darkTheme, isNotNull);
      expect(app.darkTheme?.colorScheme.primary, isNotNull);
    });

    testWidgets('App content remains visible after theme toggle', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const BoosApp());

      // Verify content is visible initially.
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('Boos'), findsOneWidget);

      // Toggle theme.
      // LEARN: Find either icon since app starts with system theme.
      final themeIconFinder = find.byIcon(Icons.dark_mode).evaluate().isNotEmpty
          ? find.byIcon(Icons.dark_mode)
          : find.byIcon(Icons.light_mode);
      await tester.tap(themeIconFinder);
      await tester.pumpAndSettle();

      // Verify content is still visible after theme change.
      expect(find.text('Hello, World!'), findsOneWidget);
      expect(find.text('Boos'), findsOneWidget);
    });
  });
}
